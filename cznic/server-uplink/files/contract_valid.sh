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

TIMEOUT=120
CA_FILE=/etc/ssl/www_turris_cz_ca.pem
OUTPUT_FILE=/usr/share/server-uplink/contract_valid
CONTRACT_URL='https://project.turris.cz/api/contract-valid.txt'


CODE=$(cat /usr/share/server-uplink/registration_code)
RESULT=$(curl -s -S -L -G --data-urlencode "registration_code=$CODE" -H "Accept: plain/text" --cacert "$CA_FILE" --cert-status -m "$TIMEOUT" "$CONTRACT_URL" | sed -ne 's/^result: *\(..*\)/\1/p')

if [ -z "$RESULT" ] ; then
	# failed to download
	[ -t 2 ] && echo "Failed to download contract status" >&2
	logger -t server_uplink -p error "Failed to download contract status"
	exit 1
fi

# test whether the code is the same
if [ -f "$OUTPUT_FILE" ] ; then
	if [ "$RESULT" == "$(cat "$OUTPUT_FILE")" ] ; then
		exit 0
	fi
fi

echo -n "$RESULT" > "$OUTPUT_FILE"
