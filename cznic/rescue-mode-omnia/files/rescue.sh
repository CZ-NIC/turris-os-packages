#!/bin/sh
#
# Turris Omnia rescue script
# (C) 2016 CZ.NIC, z.s.p.o.
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


DEBUG=1

DEV="/dev/mmcblk0"
FS_DEV="${DEV}p1"
FS_MOUNTPOINT="/mnt"
SRCFS_MOUNTPOINT="/srcmnt"
MEDKIT_FILENAME="omnia-medkit*.tar.gz"
FACTORY_SNAPNAME="@factory"

BIN_BTRFS="/usr/bin/btrfs"
BIN_MKFS="/usr/bin/mkfs.btrfs"
BIN_MOUNT="/bin/mount"
BIN_GREP="/bin/grep"
BIN_SED="/bin/sed"
BIN_UMOUNT="/bin/umount"
BIN_SYNC="/bin/sync"
BIN_AWK="/usr/bin/awk"
BIN_MV="/bin/mv"
BIN_DATE="/bin/date"
BIN_DD="/bin/dd"
BIN_FDISK="/usr/sbin/fdisk"
BIN_BLOCKDEV="/sbin/blockdev"
BIN_MKDIR="/bin/mkdir"
BIN_HWCLOCK="/sbin/hwclock"
BIN_SLEEP="/bin/sleep"
BIN_TAR="/bin/tar"
BIN_LS="/bin/ls"
BIN_SORT="/usr/bin/sort"
BIN_TAIL="/usr/bin/tail"
BIN_REBOOT="/sbin/reboot"
BIN_MDEV="`which mdev`"
[ -z "$BIN_MDEV" ] || BIN_MDEV="$BIN_MDEV -s"

d() {
	if [ $DEBUG -gt 0 ]; then
		echo "$@"
	fi
}

e() {
	echo "Error: $@" >&2
}

mount_fs() {
	d "mount_fs $1 $2"
	if ! [ -d $2 ]; then
		$BIN_MKDIR -p "$2"
	fi

	if $BIN_MOUNT | $BIN_GREP -E "on $2 ">/dev/null; then
		e "Mountpoint $2 already used. Exit."
		exit 21
	fi

	$BIN_MOUNT $1 $2
	if [ $? -ne 0 ]; then
		e "Mount $1 on $2 failed."
		return 22
	fi
}

umount_fs() {
	d "umount_fs $1"
	$BIN_UMOUNT $1
	if $BIN_MOUNT | $BIN_GREP -E "on $1 ">/dev/null; then
		$BIN_UMOUNT -f $1
	fi
	if $BIN_MOUNT | $BIN_GREP -E "on $1 ">/dev/null; then
		$BIN_MOUNT -o remount,ro $1
	fi
	$BIN_SYNC
}

reflash () {
	IMG=""
	# find image (give it 10 tries with 1 sec delay)
	for i in `seq 1 10`; do
		$BIN_MDEV
		for dev in `$BIN_AWK '$4 ~ /sd[a-z]+[0-9]+/ { print $4 }' /proc/partitions`; do
			d "Testing FS on device $dev"
			[ -b "/dev/$dev" ] || continue
			mount_fs "/dev/$dev" $SRCFS_MOUNTPOINT
			if [ $? -ne 0 ]; then
				continue
			fi
			d "Searching for ${SRCFS_MOUNTPOINT}/${MEDKIT_FILENAME} on $dev"
			IMG="$(ls -1 ${SRCFS_MOUNTPOINT}/${MEDKIT_FILENAME} | sort | tail -n 1)"
			if [ -n "${IMG}" ] && [ -f "${IMG}" ]; then
				d "Found medkit file $IMG on device $dev"
				break
			else
				IMG=""
				d "Medkit file not found on device $dev"
				umount_fs $SRCFS_MOUNTPOINT
			fi
		done
		[ -z "${IMG}" ] || break
		sleep 1
	done

	if [ -n "${IMG}" ]; then

		$BIN_DD if=/dev/zero of=$DEV bs=512 count=1
		$BIN_FDISK $DEV <<EOF
n
p
1


p
w
EOF

		$BIN_BLOCKDEV --rereadpt $DEV
		$BIN_MDEV
		$BIN_SLEEP 1
		if ! [ -e $FS_DEV ]; then
			e "Partition $FS_DEV missing. Exit."
			umount_fs $SRCFS_MOUNTPOINT
			exit 23
		fi
		$BIN_MKFS -M -f $FS_DEV
		mount_fs $FS_DEV $FS_MOUNTPOINT
		$BIN_BTRFS subvolume create "${FS_MOUNTPOINT}/@"
		ROOTDIR="${FS_MOUNTPOINT}/@"
		d "Rootdir is $ROOTDIR"
		cd $ROOTDIR
		$BIN_TAR zxf $IMG
		RD=`$BIN_DATE '+%s' -r sbin/init`
		cd /
		$BIN_BTRFS subvolume snapshot "${FS_MOUNTPOINT}/@" "${FS_MOUNTPOINT}/@factory"
		umount_fs $FS_MOUNTPOINT
		umount_fs $SRCFS_MOUNTPOINT

		check_reset_clock $RD
	else
		d "No medkit image found. Exit to shell."
		exit 0
	fi

	d "Reflash succeeded."
}

check_reset_clock () {
	D=${1:-`$BIN_DATE '+%s' -d 201606010000`}
	CD=`$BIN_DATE '+%s'`

	# reset clock to the date in param if it is before the 
	# system time or behind for more than 360 days from the system time
	if [ $D -gt $CD ] || [ $(( $D + 31104000 )) -lt $CD ]; then
		d "Resetting clock to $D ."
		$BIN_DATE "@${D}"
		$BIN_HWCLOCK -w
	else
		d "Current time `$BIN_DATE` seems to be OK. Keeping it."
	fi
}




# main
MODE=`$BIN_GREP -E "omniarescue=[0-9]+" /proc/cmdline | $BIN_SED -r 's/.*omniarescue=([0-9]+)(\s.*|)$/\1/'`
if [ -z "${MODE}" ]; then
  MODE=0
fi
d "MODE=$MODE"

if [ -z "${MODE}" ]; then
	e "Invalid (empty) mode."
	exit -10
fi

case "$MODE" in
	0)
		e "Invalid mode 0 - normal boot expected. Exit to shell."
		exit 11
		;;
	1)
		d "Mode: Rollback to the last snapshot..."
		schnapps rollback
		;;

	2)
		d "Mode: Rollback to first snapshot..."
		schnapps rollback factory
		;;
	3)
		d "Mode: Reflash..."
		reflash
		;;
	*)
		e "Invalid mode $MODE. Exit to shell."
		exit 12
esac

exit 0

