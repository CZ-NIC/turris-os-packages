#!/bin/sh
#
## Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
set -e

die() {
    echo "$1" >&2
    exit 1
}

# Detect the external storage device and verify that it makes sense to migrate
detect_and_verify() {
    if [ "$RESTORE" = no ]; then 
        SDCARD="$(blkid | sed -n 's|\(/dev/sd[a-z]\).*LABEL="turris-destroy".*|\1|p')"
        SDCARDP="$SDCARD"
    else
        SDCARD="$(blkid | sed -n 's|\(/dev/sd[a-z]\).*LABEL="turris-rootfs".*|\1|p')"
        SDCARDP="$SDCARD"
        ROOT_UUID="$(blkid "${SDCARDP}2" | sed -n 's|^/dev/.*UUID="\([0-9a-fA-F-]*\)".*|\1|p')"
    fi
    if [ -z "$SDCARD" ]; then
        SDCARD="/dev/mmcblk0"
    fi
    if [ "$SDCARD" = /dev/mmcblk0 ]; then
        SDCARDP="/dev/mmcblk0p"
    fi

    [ -b "$SDCARD" ] || die "No external storage present!"
    grep -q " / ubifs " < /proc/mounts || die "1.1 firmware required!"
}

are_you_sure() {
    local answer
    local question="Are you sure you want to lose everything on $SDCARD? (yes/No): "
    read -r -p "$question" answer
    case "$(echo "$answer" | awk '{ print tolower($0) }')" in
        y|yes)
            return 0
            ;;
        ""|n|no)
            echo "No change was performed. Exiting." >&2
            exit 0
            ;;
        *)
            die "Unknown answer: $answer"
            ;;
    esac
}

# Set chnapps to manage specified device
configure_schnapps() {
    mkdir -p /etc/schnapps
    echo "ROOT_DEV='${SDCARDP}2'" > /etc/schnapps/config
}

# This sets u-boot environment to boot from SD card
setup_uboot() {
    fw_setenv -s - <<EOF
baudrate 115200
bootargsnor root=/dev/mtdblock2 rw rootfstype=jffs2 console=ttyS0,115200
bootargsubi root=ubi0:rootfs rootfstype=ubifs ubi.mtd=9,2048 rootflags=chk_data_crc rw console=ttyS0,115200
bootdelay 1
bootfile uImage
consoledev ttyS0
ethact eTSEC3
ethprime eTSEC3
fdtaddr c00000
jffs2nand mtdblock9
jffs2nor mtdblock3
loadaddr 1000000
map_lowernorbank i2c dev 1; i2c mw 18 1 02 1; i2c mw 18 3 fd 1
map_uppernorbank i2c dev 1; i2c mw 18 1 00 1; i2c mw 18 3 fd 1
mtdids nor0=ef000000.nor,nand0=nand
mtdparts mtdparts=ef000000.nor:128k(dtb-image),1664k(kernel),1536k(root),11264k(backup),128k(cert),1024k(u-boot);nand:-(rootfs)
nandbootaddr 2100000
nandfdtaddr 2000000
netdev eth0
norbootaddr ef080000
norfdtaddr ef040000
reflash_timeout 40
stderr serial
stdin serial
stdout serial
hwconfig usb1:dr_mode=host,phy_type=ulpi
ubiboot max6370_wdt_off; setenv bootargs \$bootargsubi; ubi part rootfs; ubifsmount ubi0:rootfs; ubifsload \$nandfdtaddr /boot/fdt; ubifsload \$nandbootaddr /boot/zImage; bootm \$nandbootaddr - \$nandfdtaddr
bootcmd setexpr.b reflash *0xFFA0001F; if test \$reflash -ge \$reflash_timeout; then echo BOOT NOR; run norboot; else echo NORMAL BOOT; run turris_boot; fi
norboot max6370_wdt_off; setenv bootargs \$bootargsnor; bootm 0xef020000 - 0xef000000
root_uuid=$ROOT_UUID
bootargsbtrfs rootwait rw rootfstype=btrfs rootflags=subvol=@,commit=5 console=ttyS0,115200
mmcboot fatload mmc 0:1 \$nandfdtaddr fdt; setenv bootargs \$bootargsbtrfs root=PARTUUID=\$root_uuid; bootm \$nandbootaddr - \$nandfdtaddr
usbboot fatload usb \$devnum:1 \$nandfdtaddr fdt; setenv bootargs \$bootargsbtrfs root=PARTUUID=\$root_uuid; usb stop; bootm \$nandbootaddr - \$nandfdtaddr
mmctry mmc rescan; if fatload mmc 0:1 \$nandbootaddr zImage; then run mmcboot; fi
usbtry usb start; for devnum in 0 1 2 3 4 5 6 7 8; do if fatload usb \$devnum:1 \$nandbootaddr zImage; then run usbboot; else usb stop; fi; done
turris_boot max6370_wdt_off; run mmctry; run usbtry; run ubiboot;
EOF
}

# Setup partitions on SD card
format_sdcard() {
    dd if=/dev/zero of="$SDCARD" bs=10M count=11
    fdisk "$SDCARD" <<EOF
o
n
p
1

+100M
n
p
2


w
EOF
    mkfs.vfat -n turris-boot "${SDCARDP}1" || die "Can't create fat!"
    mkfs.btrfs -L turris-rootfs -f "${SDCARDP}2" || die "Can't format btrfs partition!"
    ROOT_UUID="$(blkid "${SDCARDP}2" | sed -n 's|^/dev/.*UUID="\([0-9a-fA-F-]*\)".*|\1|p')"
}

clean() (
    # Note: we use here rmdir to not recursivelly remove mounted FS if umount fails.
    set +e # just to continue if unmount fails with another umount
    umount "$TMPDIR/target/@/boot/tefi"
    umount "$TMPDIR/target"
    rmdir "$TMPDIR/target"
    umount "$TMPDIR/src"
    rmdir "$TMPDIR/src"
    rmdir "$TMPDIR"
)

# Copy current root to SD card
migrate_to_sdcard() {
    TMPDIR="$(mktemp -d)"
    trap clean EXIT 

    mkdir -p "$TMPDIR/target"
    mkdir -p "$TMPDIR/src"
    # Mount and migrate root filesystem
    mount "${SDCARDP}2" "$TMPDIR/target" || die "Can't mount mmclbk0p2"
    btrfs subvolume create "$TMPDIR/target/@" || die "Can't create subvolume!"
    mount -o bind / "$TMPDIR/src" || die "Can't bind btrfs mount."
    tar -C "$TMPDIR/src" -cf - . | tar -C "$TMPDIR/target/@" -xf - || die "Filesystem copy failed!"

    # import factory image - best effort, proceed even if it fails
    btrfs subvolume create "$TMPDIR/target/@factory" || die "Can't create factory subvolume!"
    cd /tmp
    wget https://repo.turris.cz/hbs/medkit/turris1x-medkit-latest.tar.gz || die "Can't download medkit"
    wget -O - https://repo.turris.cz/hbs/medkit/turris1x-medkit-latest.tar.gz.sha256 | sha256sum -c - || die "Can't verify medkit integrity"
    tar -C "$TMPDIR/target/@factory" -xzf /tmp/turris1x-medkit-latest.tar.gz  || echo "Creating factory snapshot failed" >&2

    # Copy kernel image and DTB to FAT partition
    mkdir -p "$TMPDIR/target/@/boot/tefi"
    mount "${SDCARDP}1" "$TMPDIR/target/@/boot/tefi" || die "Can't mount fat"
    # Use kernel and fdt from the future release to have access to USB drive, will be overwritten during migration
    cp /usr/share/turris-btrfs/zImage /usr/share/turris-btrfs/fdt "$TMPDIR/target/@/boot/tefi" || die "Can't copy kernel"

    # Hack to trigger migration to 5.x on reboot
    uci -c "$TMPDIR/target/@/etc/config" add_list updater.pkglists.lists=3xmigrate
    uci -c "$TMPDIR/target/@/etc/config" commit updater
    mv "$TMPDIR/target/@/etc/rc.local" "$TMPDIR/target/@/etc/rc.local.premigration"
    cat > "$TMPDIR/target/@/etc/rc.local" << EOF
#!/bin/sh
rainbow all enable blue
if pkgupdate --batch; then
    rainbow all enable green
else
    rainbow all enable red
fi

sleep 10 # Let people notice it finished

mv /etc/rc.local.premigration /etc/rc.local

# Restore LEDs
/etc/init.d/rainbow restart
/etc/init.d/led restart

# Run user init
source /etc/rc.local
EOF

    trap "" EXIT
    clean
}

##################################################################################

print_usage() {
    echo "Usage: $0 [restore]" >&2
}

print_help() {
    print_usage
    {
        echo
        echo "restore: do not format SD card but only set appropriate u-boot environment"
    } >&2
}

RESTORE="no"
for ARG in "$@"; do
    case "$ARG" in
        -h|-\?|--help)
            print_help
            exit 0
            ;;
        restore)
            RESTORE="yes"
            ;;
        *)
            echo "Unknown argument: $ARG" >&2
            print_usage
            exit 1
            ;;
    esac
done

detect_and_verify

[ "$RESTORE" = yes ] || are_you_sure

configure_schnapps

if [ "$RESTORE" = "no" ]; then
    format_sdcard
    migrate_to_sdcard
fi

setup_uboot

echo "Migration successful, please reboot!" >&2
