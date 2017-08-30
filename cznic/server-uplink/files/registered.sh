#!/bin/sh

#
# Copyright (C) 2017 CZ.NIC, z.s.p.o. (http://www.nic.cz/)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
#

set -e

usage() {
	echo "$0 <email> [<lang>]"
}

if [ "$#" -lt 1 -o "$#" -gt 2 ]; then
	usage
	exit 1
fi

EMAIL="$1"
LANG="$2"
LANG=${LANG:-en}

TIMEOUT=120
CA_FILE=/etc/ssl/www_turris_cz_ca.pem


CODE=$(cat /usr/share/server-uplink/registration_code)
URL="https://www.turris.cz/api/registration-lookup.txt?registration_code=${CODE}&email=${EMAIL}"
curl -s -S -L -H "Accept: plain/text" -H "Accept-Language: $LANG" --cacert "$CA_FILE" \
	--cert-status -m "$TIMEOUT" "$URL" -w "\ncode: %{http_code}"
