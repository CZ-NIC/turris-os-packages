#!/bin/sh
# Turris OS configuration backup utility
#
# Copyright 2014-2021 CZ.NIC z.s.p.o. (http://www.nic.cz/)
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
. /lib/functions.sh


usage() {
	echo "Usage: $0 [OPTION].. [INPUT]" >&2
}
help() {
	usage
	cat >&2 <<-"EOF"

		In default the input is expected on stdin and to be base64 encoded.
		Optionally you can specify raw INPUT (not base64 encoded).

		Options:
		  -v  Print system version backup was created on instead of backup restoration
		  -f  Force backup restoration even when it is from different major version of OS
		  -p  Preserve the Turris password
		  -n  Do not send notification about need to restart the router
		  -h  Print this help text
	EOF
}

force="n"
only_version="n"
preserve_passwords="n"
send_notification="y"
while getopts "vfpnh" opt; do
	case "$opt" in
		v)
			only_version="y"
			;;
		f)
			force="y"
			;;
		p)
			preserve_passwords="y"
			;;
		n)
			send_notification="n"
			;;
		h)
			help
			exit 0
			;;
		*)
			usage
			exit 1
			;;
	esac
done
shift $((OPTIND - 1))
[ "$#" -le 1 ] || {
	usage
	exit 1
}
input="${1:-}"
if [ -f "$input" ]; then
	archive="$1"
else
	archive="/tmp/backup-$$.tar"
	case "$input" in
		"")
			base64 -d >"$archive"
			;;
		"-")
			cat >"$archive"
			;;
		*)
			cat <"$input" >"$archive"
			;;
	esac
	trap 'rm -f "$archive"' INT QUIT TERM ABRT EXIT
fi

version="$(tar -xOf backup.tar.bz2 etc/turris-version || echo "unknown")"
if [ "$only_version" = "y" ]; then
	echo "$version"
	exit 0
fi

if [ "$force" = "n" ]; then
	current="$(cat /etc/turris-version)"
	if [ "${version%%.*}" != "${current%%.*}" ]; then
		cat >&2 <<-EOF
		You are trying to recover backup from a different major version of OS.
		This is protection against possibly dangerous recoveries. The major OS
		version commonly update system configuration in the incompatible way and
		recovery of obsolete configuration can make device unaccessible.
		The current versions is '$current' while backup was created on '$version'.
		You can use -f option to force recovery anyway.
		EOF
		exit 1
	fi
fi

if [ "$preserve_passwords" = "y" ]; then
	foris_password="$(uci -q get foris.auth.password || true)"
	auth_password="$(uci -q get turris-auth.auth.password || true)"
	root_password="$(sed -n 's/^root:\([^:]\+\):.*/\1/p' /etc/shadow || true)"
fi

tar -xjf "$archive" -C /

if [ "$preserve_passwords" = "y" ]; then
	if [ -n "$foris_password" ]; then
		uci set "foris.auth.password=$foris_password"
		uci commit foris.auth.password
	fi
	if [ -n "$auth_password" ]; then
		uci set "turris-auth.auth.password=$auth_password"
		uci commit turris-auth.auth.password
	fi
	if [ -n "$auth_password" ]; then
		sed -i "s/^root:\([^:]\+\):/root:$root_password:/" /etc/shadow
	fi
fi


if [ "$send_notification" = "y" ]; then
	create_notification -t -s restart \
		'Configuration backup was restored. To fully apply all configuration changes the router has to be restarted.'
fi
