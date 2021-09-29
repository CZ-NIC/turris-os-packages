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
turris_version="/etc/turris-version"

config_load "backups"

# These are files requested to be backed up by OpenWrt packages
sysupgrade_files() {
	# Note: this is taken from sysupgrade script
	# https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=package/base-files/files/sbin/sysupgrade;h=7e0a00e13b8ee4be7163936fd01a7beff0ce5c99;hb=HEAD#l116
	sed -ne '/^[[:space:]]*$/d; /^#/d; p' /etc/sysupgrade.conf /lib/upgrade/keep.d/* 2>/dev/null \
		| while read -r path; do
			[ -e "$path" ] || continue
			find -H "$path" -type f -o -type l
		done
}

# These are configuration files that were modified
modified_configs_files() {
	# Note: this is taken from sysupgrade script as well (see link in sysupgrade_files)
	awk '
		BEGIN { conffiles = 0 }
		/^Conffiles:/ { conffiles = 1; next }
		!/^ / { conffiles = 0; next }
		conffiles == 1 { print }
	' /usr/lib/opkg/status \
		| while read -r file csum; do
			[ -r "$file" ] || continue
			echo "${csum}  ${file}" | busybox sha256sum -sc - || echo "$file"
		done
}

# These are files we want automatically include on Turris
default_files() {
	# UCI configuration
	find -H /etc/config -type f \( -name "*-opkg" -o -name ".*" -o -print \)
	# Updater configuration (the Turris ones contain warning that they should
	# not be edited and that way we can filter them out)
	find -H /etc/updater/conf.d -type f \( -exec grep -qF "Don't edit it." \{\} \; -o -print \)
}

# Files/directories configured in backups UCI
uci_files() {
	config_list_foreach "generate" "dirs" _uci_files_dirs
}
_uci_files_dirs() {
	find -H "$1" -type f -o -type l
}

# This provides list of all files configured for backup and available in system
files() {
	local include_sysupgrade include_modified_configs include_default
	config_get_bool include_sysupgrade "generate" "include_sysupgrade" "1"
	config_get_bool include_modified_configs "generate" "include_modified_configs" "0"
	config_get_bool include_default "generate" "include_default" "1"
	{
		[ -f "$turris_version" ] \
			&& echo "$turris_version"
		[ "$include_sysupgrade" = "1" ] \
			&& sysupgrade_files
		[ "$include_modified_configs" = "1" ] \
			&& modified_configs_files
		[ "$include_default" = "1" ] \
			&& default_files
		uci_files
	} | sort -u
}



usage() {
	echo "Usage: $0 [OPTION].. [OUTPUT]" >&2
}
help() {
	usage
	cat >&2 <<-"EOF"

		In default the output is generated to stdout in base64 encoding.
		Optionally you can specify OUTPUT where raw backup should be stored.
		The backup is simply tar.bz2 archive with files.

		Options:
		  -l  List all files and links that would be backed up
		  -h  Print this help text
	EOF
}

while getopts "lh" opt; do
	case "$opt" in
		l)
			files
			exit 0
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
output="${1:-}"
if [ -z "$output" ] || [ "$output" = "-" ]; then
	archive="/tmp/backup-$$.tar"
	trap 'rm -f "$archive"' INT QUIT TERM ABRT EXIT
else
	archive="${1%.bz2}" # This prevents bzip2 compain about suffix
fi

files | sed 's|^/||' | xargs /usr/bin/tar -rf "$archive" -C /

bzip2 -z -f -9 "$archive"
archive="$archive.bz2"

case "$output" in
	"")
		base64 "$archive"
		;;
	"-")
		cat "$archive"
		;;
	*)
		mv "$archive" "$output"
		;;
esac
