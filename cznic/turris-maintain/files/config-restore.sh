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

DIR=/tmp/restore-$$
mkdir -p "$DIR"
trap 'rm -rf "$DIR"' EXIT INT QUIT TERM ABRT
cd "$DIR"
base64 -d | bzip2 -cd | tar xp
# Here we have a special-case/hack for foris password. It was requested NOT to restore the
# password, as potentially confusing action. So we unpack the backed-up configuration,
# extract the current password and implant it into the configuration. Then we just copy
# the configs and overwrite the current ones.
PASSWD="$(uci -q -c "/etc/config" get foris.auth.password || echo -n)"
[ -z "$PASSWD" ] || uci -c "$DIR/etc/config" set foris.auth.password="$PASSWD"
uci -c "$DIR/etc/config" commit
cp -rf "$DIR/"* "/"
cd /
rm -rf "$DIR"
