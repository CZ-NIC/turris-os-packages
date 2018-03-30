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


die() {
	echo "$1" >&2
	exit 1
}

[ -b /dev/mmcblk0 ]         || die "No MicroSD card present!"
[ -n "`mount | grep ubi`" ] || die "1.1 firmware required!"

mkdir -p /etc/schnapps
echo 'ROOT_DEV="/dev/mmcblk0p2"' > /etc/schnapps/config

ANS=""
echo "Are you sure you want to lose everything on mmcblk0? (yes/no)"
read ANS
if [ "$ANS" \!= "yes" ]; then
	exit 0
fi

dd if=/dev/zero of=/dev/mmcblk0 bs=10M count=11
fdisk /dev/mmcblk0 <<EOF
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
mkdir -p /tmp/btrfs-convert/target
mkdir -p /tmp/btrfs-convert/src
mkfs.vfat /dev/mmcblk0p1 || die "Can't create fat!"
mkfs.btrfs -f /dev/mmcblk0p2 || die "Can't format btrfs partition!"
mount /dev/mmcblk0p2 /tmp/btrfs-convert/target || die "Can't mount mmclbk0p2"
btrfs subvolume create /tmp/btrfs-convert/target/@ || die "Can't create subvolume!"
mount -o bind / /tmp/btrfs-convert/src || die "Can't bind btrfs mount."
tar -C /tmp/btrfs-convert/src -cf - . | tar -C /tmp/btrfs-convert/target/@ -xf - || die "Filesystem copy failed!"

mkdir -p /tmp/btrfs-convert/target/@/boot/tefi
mount /dev/mmcblk0p1 /tmp/btrfs-convert/target/@/boot/tefi || die "Can't mount fat"
cp /boot/zImage /boot/fdt /tmp/btrfs-convert/target/@/boot/tefi || die "Can't copy kernel"
umount /tmp/btrfs-convert/target/@/boot/tefi
umount /tmp/btrfs-convert/target
umount /tmp/btrfs-convert/src

# Setup u-Boot
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
nfsboot setenv bootargs root=/dev/nfs rw nfsroot=\$serverip:\$rootpath ip=\$ipaddr:\$serverip:\$gatewayip:\$netmask:\$hostname:\$netdev:off console=\$consoledev,\$baudrate \$othbootargs;tftp \$loadaddr \$bootfile;tftp \$fdtaddr \$fdtfile;bootm \$loadaddr - \$fdtaddr
norbootaddr ef080000
norfdtaddr ef040000
ramboot setenv bootargs root=/dev/ram rw console=\$consoledev,\$baudrate \$othbootargs ramdisk_size=\$ramdisk_size;tftp \$ramdiskaddr \$ramdiskfile;tftp \$loadaddr \$bootfile;tftp \$fdtaddr \$fdtfile;bootm \$loadaddr \$ramdiskaddr \$fdtaddr
ramdisk_size 120000
ramdiskaddr 2000000
ramdiskfile rootfs.ext2.gz.uboot
reflash_timeout 40
rootpath /opt/nfsroot
stderr serial
stdin serial
stdout serial
tftpflash tftpboot \$loadaddr \$uboot; protect off 0xeff40000 +\$filesize; erase 0xeff40000 +\$filesize; cp.b \$loadaddr 0xeff40000 \$filesize; protect on 0xeff40000 +\$filesize; cmp.b \$loadaddr 0xeff40000 \$filesize
ubiboot max6370_wdt_off; setenv bootargs \$bootargsubi; ubi part rootfs; ubifsmount ubi0:rootfs; ubifsload \$nandfdtaddr /boot/fdt; ubifsload \$nandbootaddr /boot/zImage; bootm \$nandbootaddr - \$nandfdtaddr
uboot u-boot.bin
backbootcmd setexpr.b reflash *0xFFA0001F;if test \$reflash -ge \$reflash_timeout; then echo BOOT NOR; run norboot; else echo BOOT NAND; run ubiboot; fi
bootcmd setexpr.b reflash *0xFFA0001F;if test \$reflash -ge \$reflash_timeout; then echo BOOT NOR; run norboot; else echo BOOT NAND; mmc rescan; if fatload mmc 0:1 \$nandbootaddr zImage; then run mmcboot; else run ubiboot; fi; fi
norboot max6370_wdt_off; env default -a; saveenv; setenv bootargs \$bootargsnor; bootm 0xef020000 - 0xef000000
bootargsmmc root=/dev/mmcblk0p2 rootwait rw rootfstype=btrfs rootflags=subvol=@,commit=5 console=ttyS0,115200
mmcboot max6370_wdt_off; fatload mmc 0:1 \$nandfdtaddr fdt; setenv bootargs \$bootargsmmc; bootm \$nandbootaddr - \$nandfdtaddr
EOF
echo "Migration successful, please reboot!"
