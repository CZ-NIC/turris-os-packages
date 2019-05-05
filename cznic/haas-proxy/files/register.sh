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
URL='https://haas.nic.cz/api/turris/register'

if [ -z "$(uci -q get haas.settings.token 2>/dev/null)" ]; then
	CODE=$(cat /usr/share/server-uplink/registration_code)
	TOKEN=$(curl -sS -H "Content-Type: application/json" \
		-X POST -d "{\"registration_code\": \"${CODE}\"}" \
		-m "${TIMEOUT}" \
		"${URL}" | sed -n -e 's/^.*"token":[[:blank:]]*"\([^"]*\)".*/\1/p')

	if [ -z "$TOKEN" ] ; then
		[ -t 2 ] && echo "Failed to get haas registration token" >&2
		logger -t haas-proxy -p error "Failed to get haas registration token"
		exit 1
	fi

	uci set haas.settings.token="${TOKEN}" && uci commit
	/etc/init.d/haas-proxy restart
fi
