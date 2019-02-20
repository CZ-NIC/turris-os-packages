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

mount -t sysfs none /sys
mount -t proc none /proc
mdev -s

simple_udev() {
    while sleep 5; do
        mdev -s
        if [ -e /dev/watchdog0 ] && ! pidof watchdog > /dev/null && [ \! -f /tmp/halt ]; then
            watchdog -t 10 -T 60 /dev/watchdog0
        fi
    done
}

# Load all modules, busybox modprobe handles dependencies
depmod
find /lib/modules/ -name '*.ko' -exec basename \{\} .ko \; | xargs -t -n 1 modprobe

# Wait for stuff to settle down
simple_udev &
while [ \! -b /dev/mmcblk0 ] || [ \! -c /dev/i2c-0 ]; do
    sleep 1
done

# Run the rescue while flashing the red light
rainbow all enable red
/bin/rescue.sh || setsid cttyhack sh
rainbow all enable white
touch /tmp/halt
killall watchdog

# Reboot
echo "Doing sysrq reboot as busybox one doesn't work"
sync
echo 0 > /proc/sysrq-trigger
echo b > /proc/sysrq-trigger
