#!/bin/sh

# Global defaults

BOARD=mox
DELAY=60
RESCUE_IF="eth0"
HAVE_BTRFS=1
REPARTITION=1

MODE=1
cmd_mode="$(sed -n 's|.*\ rescue_mode=\([0-9]\+\).*|\1|p' /proc/cmdline)"
[ -z "$cmd_mode" ] || MODE="$cmd_mode"

# Board specific functions

if [ "$BOARD" = mox ]; then 

    handle_reset() {
        while sleep 0.2; do
            pressed=0
            while [ "$(cat /sys/class/gpio/gpio466/value)" -eq 0 ]; do
                sleep 0.1
                pressed="$(expr "$pressed" + 1)"
                [ "$pressed" -gt 20 ] || continue
                echo "Rebooting as requested!"
                reboot
            done
        done
    }

    board_init() {
        echo 466 > /sys/class/gpio/export
        echo in > /sys/class/gpio/gpio466/direction
        echo default-on > /sys/class/leds/red/trigger
        mkdir -p /etc
        echo '/dev/mtd2 0 0x00010000' > /etc/fw_env.config
        BUTTON_STATE="$(cat /sys/class/gpio/gpio466/value)"
        TARGET_DRIVE="/dev/mmcblk1"
        TARGET_PART="1"
        handle_reset &
    }

    check_for_mode_change() {
        new_btn_state="$(cat /sys/class/gpio/gpio466/value)"
        chk_ret=1
        if [ "$new_btn_state" -eq 0 ] && [ "$new_btn_state" -ne "$BUTTON_STATE" ]; then
            chk_ret=0
        fi
        BUTTON_STATE="$new_btn_state"
        return $chk_ret
    }

    display_mode() {
        echo none > /sys/class/leds/red/trigger
        sleep 0.5
        for i in $(seq 1 "$MODE"); do
            sleep 0.2
            echo default-on > /sys/class/leds/red/trigger
            sleep 0.2
            echo none > /sys/class/leds/red/trigger
        done
        sleep 0.5
        echo default-on > /sys/class/leds/red/trigger
    }

    board_reset() {
        mtd erase /dev/mtd1
    }

    set_pulic_port() {
        :
    }

    busy() {
        echo timer > /sys/class/leds/red/trigger
        while sleep 0.5; do [ "$(cat /sys/class/gpio/gpio466/value)" -eq 1 ] || reboot; done &
    }

    die() {
        ret_code="$1"
        shift
        if [ -f /tmp/debug.txt ]; then
            echo "Debug info:"
            cat /tmp/debug.txt
        fi
        echo "$1"
        setsid cttyhack sh &
        while sleep 0.5; do
            sleep 0.3
            for i in $(seq 1 "$ret_code"); do
                sleep 0.2
                echo default-on > /sys/class/leds/red/trigger
                sleep 0.2
                echo none > /sys/class/leds/red/trigger
            done
            sleep 1.5
        done
    }

fi

# Generic helper functions

reset_uenv() {
    fw_setenv bootcmd 'env default -f -a; saveenv; reset'
}

wait_for_mode_change() {
    echo "Now is your chance to change a mode from $MODE to something else, press the button to do so"
    waited=0
    display_mode
    half_delay="$(expr "$DELAY" / 2)"
    echo "Waiting for $(expr $DELAY /10)s ..."
    while [ "$waited" -le "$DELAY" ]; do
        if check_for_mode_change; then
            waited=-9
            eval NEXT='$MODE'"$MODE"'_NEXT'
            if [ -n "$NEXT" ]; then
                MODE="$NEXT"
            else
                MODE="$(expr "$MODE" + 1 )"
            fi
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
    while ! udhcpc -i "$RESCUE_IF" $DHCP_OPTS; do
        echo "No DHCP :-("
        sleep 2
        i="$(expr "$i" + 1)"
        [ "$i" -lt "$tries" ] || die 2 "Can't get IP"
    done
    echo "Got IPv4!"
    ip a s
    ip r s
    grep -q nameserver /etc/resolv.conf || echo nameserver 217.31.204.130 > /etc/resolv.conf
    mkdir -p /mnt/src
    i=0
    while ! { \
        wget --no-check-certificate -O /mnt/src/medkit.tar.gz https://repo.turris.cz/hbs/medkit/medkit-$BOARD-latest.tar.gz || \
        wget --no-check-certificate -O /mnt/src/medkit.tar.gz https://repo.turris.cz/hbs/medkit/$BOARD-medkit-latest.tar.gz;   \
        }; do
            echo "Can't download image :-("
            sleep 2
            i="$(expr "$i" + 1)"
            [ "$i" -lt "$tries" ] || die 2 "Can't get image"
    done
    i=0
    while ! { \
        wget --no-check-certificate -O /mnt/src/medkit.tar.gz.sig https://repo.turris.cz/hbs/medkit/medkit-$BOARD-latest.tar.gz.sig || \
        wget --no-check-certificate -O /mnt/src/medkit.tar.gz.sig https://repo.turris.cz/hbs/medkit/$BOARD-medkit-latest.tar.gz.sig;   \
        }; do
            echo "Can't download signature :-("
            sleep 2
            i="$(expr "$i" + 1)"
            [ "$i" -lt "$tries" ] || die 2 "Can't get signature"
    done
    usign -V -m /mnt/src/medkit.tar.gz -P /etc/opkg/keys || die 2 "Can't validate signature"
    echo "medkit.tar.gz" > /tmp/medkit-file
}

find_medkit() {
    echo "Searching for medkit"
    i=0
    mkdir -p /mnt/src
    rm -f /tmp/medkit-drive /tmp/medkit-file
    while [ "$i" -lt "$1" ] && [ \! -f /tmp/medkit-file ]; do
        sleep 1
        for d in /dev/mmcblk*p* /dev/sd*; do
            [ -e "$d" ] || continue
            mount "$d" /mnt/src || continue
            echo "Trying device $d"
            for f in $(cd /mnt/src; ls -1 $BOARD-medkit*.tar.gz medkit-$BOARD.tar.gz medkit-$BOARD-*.tar.gz); do
                [ -f "/mnt/src/$f" ] || continue
                echo "Found $f on device $d"
                if [ -f "/mnt/src/$f".md5 ]; then
                    [ "$(cat "/mnt/src/$f".md5)" = "$(cd /mnt/src; md5sum "$f")" ] || continue
                fi
                if [ -f "/mnt/src/$f".sha256 ]; then
                    [ "$(cat "/mnt/src/$f".sha256)" = "$(cd /mnt/src; sha256sum "$f")" ] || continue
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

format_and_mount_target() {
    if [ -n "$HAVE_BTRFS" ]; then
        if [ -n "$REPARTITION" ]; then
            echo "Repartitioning the drive..."
            dd if=/dev/zero of="$TARGET_DRIVE" bs=1024 count=10240 >> /tmp/debug.txt 2>&1
            fdisk "$TARGET_DRIVE" >> /tmp/debug.txt 2>&1 <<EOF
n
p
$TARGET_PART


p
w
EOF
            [ $? -eq 0 ] || die 3 "Partitioning drive failed" 
            sleep 1
            sync
        fi
        fdisk -l "$TARGET_DRIVE" >> /tmp/debug.txt
        echo "Formatting the drive..."
        mkfs.btrfs -f "$TARGET_DRIVE"p"$TARGET_PART" >> /tmp/debug.txt 2>&1 || die 4 "Can't format the partition"
        sync
        mkdir -p "$1"
        mount "$TARGET_DRIVE"p"$TARGET_PART" "$1" || die 5 "Can't mount the partition"
        btrfs subvolume create "$1"/@ >> /tmp/debug.txt 2>&1 || die 6 "Can't create a subvolume"
        ln -s @/boot/boot-btrfs.scr "$1"/boot.scr
        umount "$1"
        mount "$TARGET_DRIVE"p"$TARGET_PART" -o subvol=@ "$1"
    fi
}

create_factory() {
    echo "Backing up the current image as new factory"
    if [ -n "$HAVE_BTRFS" ]; then
        mkdir -p /mnt/tmp
        mount "$TARGET_DRIVE"p"$TARGET_PART" /mnt/tmp
        btrfs subvolume snapshot /mnt/tmp/@ /mnt/tmp/@factory
        umount -fl /mnt/tmp
        sync
    fi
}

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
    tar -C /mnt/trg -xzf /mnt/src/"$(cat /tmp/medkit-file)" >> /tmp/debug.txt
    echo "Rootfs should be ready"
    check_clock /mnt/trg/etc/shadow
    umount -fl /mnt/trg
    sync
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
}

# Simple udev
simple_udev() {
    while true; do
        mdev -s
        if [ -e /dev/watchdog0 ] && ! pidof watchdog > /dev/null; then
            watchdog -t 10 -T 60 /dev/watchdog0
        fi
        sleep 0.5
    done
}

# All the stuff proper init system should do and nothing more
init() {
    echo "Initializing the system"
    mount -t sysfs none /sys
    mount -t proc none /proc
    mkdir /dev/pts
    mount -t devpts devpts /dev/pts
    sleep 1
    simple_udev &
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
    set_public_port
    ip link set dev "$RESCUE_IF" up
    ip addr add dev "$RESCUE_IF" 192.168.1.1/24
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

# Main loop

init
board_init
if [ -n "$HAVE_BTRFS" ]; then
    mkdir -p /etc/schnapps
    echo "ROOT_DEV='${TARGET_DRIVE}p${TARGET_PART}'" > /etc/schnapps/config
    MODE1_NEXT=2
else
    MODE1_NEXT=4
fi
wait_for_mode_change
echo "Mode $MODE selected!"
busy
mode_"$MODE"
reboot
