#!/bin/sh
# Turris OS configuration backup utility
#
# Copyright 2014-2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
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
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

set -e

DIR=/tmp/backup-$$
SRC=/etc/config
mkdir -p "$DIR"/etc
trap 'rm -rf "$DIR"' EXIT INT QUIT TERM ABRT
cd "$DIR"/etc
cp -a "$SRC" config
cd ..
uci -q -c "$DIR"/etc/config delete foris.auth.password || true
uci -c "$DIR"/etc/config commit
if [ -d /etc/updater ] ; then
	# Back up the updater options (mostly lists of packages)
	cp -a /etc/updater "$DIR"/etc
	# But exclude things coming from packages not marked as configs
	rm -rf "$DIR"/etc/updater/keys
	rm -rf "$DIR"/etc/updater/hook_*
fi
uci -q -d '
' get backups.generate.dirs | while read dir ; do
	DNAME=$(dirname "$dir")
	mkdir -p "$DIR"/"$DNAME"
	cp -a "$dir" "$DIR"/"$DNAME"/
done
tar c . | bzip2 -9c | base64
