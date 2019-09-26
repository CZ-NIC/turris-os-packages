#!/bin/sh

# Generic helper functions
reset_uenv() {
    if [ -n "$(fw_printenv root_uuid 2> /dev/null)" ]; then
        fw_setenv bootcmd "env default -f -a; setenv root_uuid $(blkid "$NEW_TARGET_PART" | sed 's|.*UUID="\([^"]*\)".*|\1|'); saveenv; reset"
    else
        fw_setenv bootcmd 'env default -f -a; saveenv; reset'
    fi
}

enable_btrfs() {
    MODE1_NEXT=2
    mkdir -p /etc/schnapps
    echo "ROOT_DEV='${TARGET_PART}'" > /etc/schnapps/config
}

disable_btrfs() {
    rm -rf /etc/schnapps
    MODE1_NEXT=3
}

override_root() {
    if [ -n "$(fw_printenv root_uuid 2> /dev/null)" ]; then
        UUID="$(fw_printenv root_uuid | sed 's|root_uuid=||')"
        NEW_TARGET_PART="$(blkid | sed -n 's|^/dev/\([^:]*\):.*UUID="'"$UUID"'".*|\1|p' | head -n 1)"
        if [ "$NEW_TARGET_PART" ] && [ -d "/sys/class/block/$NEW_TARGET_PART" ]; then
            NEW_TARGET_DRIVE="$(ls -d /sys/class/block/*/"$NEW_TARGET_PART" | sed 's|/.*/\([^/]*\)/'"$NEW_TARGET_PART"'|\1|')"
            if [ -d "/sys/class/block/$NEW_TARGET_DRIVE" ]; then
                TARGET_PART="/dev/$NEW_TARGET_PART"
                PART_NO="$(echo "$NEW_TARGET_PART" | sed -n 's|.*[^0-9]\([0-9]\+\)$|\1|p')"
                TARGET_DRIVE="/dev/$NEW_TARGET_DRIVE"
            fi
        fi
        echo "Newly selected root device is $TARGET_PART"
    fi
}

wait_for_mode_change() {
    echo "Now is your chance to change a mode from $MODE to something else, press the button to do so"
    waited=0
    display_mode
    half_delay="$(expr "$DELAY" / 2)"
    echo "Waiting for $(expr $DELAY / 10)s ..."
    while [ "$waited" -le "$DELAY" ]; do
        if check_for_mode_change; then
            waited=-9
            next_mode
            echo "Mode changed to $MODE"
            eval echo '$MODE'"$MODE"
            display_mode
        elif [ "$waited" -eq "$half_delay" ]; then
            display_mode
        fi
        [ "$(expr $waited % 10)" -ne 0 ] || echo "$(expr \( "$DELAY" - "$waited" \) / 10)s left"
        sleep 0.1
        waited="$(expr $waited + 1)"
    done
}

DHCP_OPTS="-qfn"
download_medkit() {
    tries=3
    i=0
    ip link set up dev "$WAN_IF"
    while ! udhcpc -i "$WAN_IF" $DHCP_OPTS; do
        echo "No DHCP :-("
        sleep 2
        i="$(expr "$i" + 1)"
        [ "$i" -lt "$tries" ] || die 2 "Can't get IP"
    done
    echo "Got IPv4!"
    ip addr show
    ip route show
    grep -q nameserver /etc/resolv.conf || echo nameserver 193.17.47.1 > /etc/resolv.conf
    mkdir -p /mnt/src
    # Download medkit and signature
    for ext in tar.gz tar.gz.sig; do
        i=0
        # We are checking signature, so we don't care about https certificate
        while ! { \
            wget --no-check-certificate -O /mnt/src/medkit.$ext https://repo.turris.cz/hbs/medkit/medkit-$BOARD-latest.$ext || \
            wget --no-check-certificate -O /mnt/src/medkit.$ext https://repo.turris.cz/hbs/medkit/$BOARD-medkit-latest.$ext;   \
            }; do
                echo "Can't download $BOARD-medkit-latest.$ext :-("
                sleep 2
                i="$(expr "$i" + 1)"
                [ "$i" -lt "$tries" ] || die 2 "Can't get $BOARD-medkit-latest.$ext"
        done
    done
    usign -V -m /mnt/src/medkit.tar.gz -P /etc/opkg/keys || die 2 "Can't validate signature"
    echo "medkit.tar.gz" > /tmp/medkit-file
}

# Takes as an argument number of retries
find_medkit() {
    echo "Searching for medkit"
    i=0
    retries="$1"
    mkdir -p /mnt/src
    rm -f /tmp/medkit-drive /tmp/medkit-file
    # Till we run out of retries or find the image
    while [ "$i" -lt "$retries" ] && [ \! -f /tmp/medkit-file ]; do
        sleep 1
        i="$(expr "$i" + 1)"
        # Search all block devices
        for d in /dev/mmcblk*p* /dev/sd*; do
            [ -e "$d" ] || continue
            mount "$d" /mnt/src || continue
            echo "Trying device $d"
            # Search all files and find the best one
            for f in $(cd /mnt/src; ls -1 $BOARD-medkit*.tar.gz medkit-$BOARD.tar.gz medkit-$BOARD-*.tar.gz); do
                [ -f "/mnt/src/$f" ] || continue
                echo "Found $f on device $d"
                if [ -f "/mnt/src/$f".md5 ] && [ "$(cat "/mnt/src/$f".md5)" \!= "$(cd /mnt/src; md5sum "$f")" ]; then
                    echo "Wrong md5 sum for $f"
                    continue
                fi
                if [ -f "/mnt/src/$f".sha256 ] && [ "$(cat "/mnt/src/$f".sha256)" \!= "$(cd /mnt/src; sha256sum "$f")" ]; then
                    echo "Wrong sha256 sum for $f"
                    continue
                fi
                if [ -f "/mnt/src/$f".sig ]; then
                    usign -V -m "/mnt/src/$f" -P /etc/opkg/keys || continue
                fi
                echo "Nothing wrong with it"
                if expr "$f" \> "$(cat /tmp/medkit-file 2> /dev/null) > /dev/null"; then
                    echo "And its our newest one!"
                    echo "$d" > /tmp/medkit-drive
                    echo "$f" > /tmp/medkit-file
                fi
            done
            umount -fl /mnt/src
        done
    done
    if [ \! -f /tmp/medkit-file ] && [ -f /mnt/src/medkit.tar.gz ]; then
        echo "No medkit on any drive found, using built-in"
        echo "medkit.tar.gz" > /tmp/medkit-file 
    fi
    [ -f /tmp/medkit-file ] || die 2 "No valid medkit found!"
}

# Takes as an argument directory where to mount target drive
format_and_mount_target() {
    trg_mnt_pth="$1"
    if [ -n "$HAVE_BTRFS" ]; then
        if [ -n "$REPARTITION" ]; then
            echo "Repartitioning the drive..."
            fdisk "$TARGET_DRIVE" >> /tmp/debug.txt 2>&1 <<EOF
o
n
p
$PART_NO


p
w
EOF
            [ $? -eq 0 ] || die 3 "Partitioning drive failed" 
        fi
        fdisk -l "$TARGET_DRIVE" >> /tmp/debug.txt
        echo "Formatting the drive..."
        mkfs.btrfs -f "$TARGET_PART" >> /tmp/debug.txt 2>&1 || die 4 "Can't format the partition"
        mkdir -p "$trg_mnt_pth"
        mount "$TARGET_PART" "$trg_mnt_pth" || die 5 "Can't mount the partition"
        btrfs subvolume create "$trg_mnt_pth"/@ >> /tmp/debug.txt 2>&1 || die 6 "Can't create a subvolume"
        ln -s @/boot/boot.scr "$trg_mnt_pth"/boot.scr
        umount "$trg_mnt_pth"
        mount "$TARGET_PART" -o subvol=@ "$trg_mnt_pth"
    fi
}

create_factory() {
    echo "Backing up the current image as new factory"
    if [ -n "$HAVE_BTRFS" ]; then
        mkdir -p /mnt/tmp
        mount "$TARGET_PART" /mnt/tmp
        btrfs subvolume snapshot /mnt/tmp/@ /mnt/tmp/@factory
        sync
        umount -fl /mnt/tmp
    fi
}

# Adjust RTC if image is from the future
check_clock() {
    hwclock -s
    current_date="$(date '+%s')"
    image_date="$(date '+%s' -r "$1")"
    if [ "$current_date" -lt "$image_date" ]; then
        echo "Adjusting hardware clock"
        date "@$image_date"
        hwclock -w
    fi
}

reflash() {
    if [ -f /tmp/medkit-drive ]; then
        if expr "$(cat /tmp/medkit-drive)" : "${TARGET_DRIVE}.*" > /dev/null; then
            echo "Copying medkit to RAM"
            mkdir -p /mnt/tmp
            mount "$(cat /tmp/medkit-drive)" /mnt/tmp
            cp /mnt/tmp/"$(cat /tmp/medkit-file)" /mnt/src
            umount -fl /mnt/tmp
            rm -f /tmp/medkit-drive
        else
            mount "$(cat /tmp/medkit-drive)" /mnt/src
        fi
    fi
    format_and_mount_target /mnt/trg
    echo "Unpacking rootfs to the target directory"
    mount >> /tmp/debug.txt
    tar -C /mnt/trg -xzf /mnt/src/"$(cat /tmp/medkit-file)" >> /tmp/debug.txt || die 7 "Flashing failed!!!"
    echo "Rootfs should be ready"
    check_clock /mnt/trg/etc/shadow
    sync
    umount -fl /mnt/trg
    create_factory
}

reboot() {
    echo "Rebooting!"
    sync
    echo "Debug info:"
    cat /tmp/debug.txt 2> /dev/null
    rm -f "$(which watchdog)"
    killall watchdog 2> /dev/null
    /sbin/reboot -f
    echo s > /proc/sysrq-trigger
    echo b > /proc/sysrq-trigger
    # Should be enough to let watchdog kill us
    sleep 999999
}

# Simple udev
simple_udev() {
    while true; do
        mdev -s
        if [ -e /dev/watchdog0 ] && ! pidof watchdog > /dev/null; then
            watchdog -t 10 -T 60 /dev/watchdog0
        fi
        sleep 1
    done
}

# All the stuff proper init system should do and nothing more
init() {
    echo "Initializing the system"
    mount -t sysfs none /sys
    mount -t proc none /proc
    mkdir /dev/pts
    mount -t devpts devpts /dev/pts
    ip addr add 127.0.0.1/8 dev lo
    ip link set up dev lo
    simple_udev &
}

next_mode() {
    # Next mode in line is in MODE[1-9]_NEXT variable, so some of them can be skipped or rearranged
    eval NEXT='$MODE'"$MODE"'_NEXT'
    if [ -n "$NEXT" ]; then
        MODE="$NEXT"
    else
        # Default next mode is one number higher if not set
        MODE="$(expr "$MODE" + 1 )"
    fi
}

fetch_cmd_mode() {
    cmd_mode="$(sed -n 's|.*rescue_mode=\([0-9]\+\).*|\1|p' /proc/cmdline)"
    echo "Rescue mode $cmd_mode + 1 selected on cmdline"
    if [ -n "$cmd_mode" ]; then
        MODE="$(expr "$cmd_mode" + 1)"
        if [ "$MODE" -gt 7 ] || [ "$MODE" -le 0 ] || [ -z "$MODE" ]; then
            MODE=1
        fi
    fi
}

# Various modes

MODE1="Reset"
mode_1() {
    reboot
}

# Rollback
MODE2="Btrfs rollback"
mode_2() {
    echo "Running btrfs rollback"
    schnapps rollback
}

# Factory reset
MODE3="Factory reset"
mode_3() {
    echo "Running factory reset"
    reset_uenv
    schnapps rollback factory
}

# Reflash from USB
MODE4="USB flash"
mode_4() {
    echo "Running USB flash"
    find_medkit 5
    reset_uenv
    reflash
}

# Open open ssh console
MODE5="Unsecure SSH on 192.168.1.1"
mode_5() {
    echo "Running unsecure ssh"
    ip link add name br_lan type bridge
    ip link set br_lan up
    for i in $RESCUE_IF $RESCUE_IF_UP; do
        ip link set $i up
    done
    for i in $RESCUE_IF; do
        ip link set $i master br_lan
        ip link set $i up
    done
    ip link set br_lan up
    ip addr add 192.168.1.1/24 dev br_lan
    rm -f /etc/dropbear/*
    dropbear -R -B -E
    setsid cttyhack sh
    reboot
}

# Flash directly from the internet
MODE6="Flash from the Cloud :-)"
mode_6() {
    echo "Flashing from the Cloud :-)"
    download_medkit
    reset_uenv
    reflash
}

MODE7="Serial console"
MODE7_NEXT=1
mode_7() {
    echo "Running shell"
    setsid cttyhack sh
    reboot
}
MAX_MODE=7

