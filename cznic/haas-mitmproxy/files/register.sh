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


TIMEOUT=120
CA_FILE=/etc/ssl/www_turris_cz_ca.pem  # let's encrypt inside

if uci -q get haas.settings.token 2>&1 >/dev/null ; then
	:
else
	set -e
	CODE=$(cat /usr/share/server-uplink/registration_code)
	URL="https://haas.nic.cz/api/turris/register"
	TOKEN=$(curl -s -H "Content-Type: application/json" \
		-X POST -d "{\"registration_code\": \"${CODE}\"}" \
		--cacert "$CA_FILE" \
		-m "${TIMEOUT}" \
		"${URL}" | sed -e 's/^[^"]*"token":\s*"\([^"]*\)".*/\1/')

	uci set haas.settings.token="${TOKEN}" && uci commit
	/etc/init.d/haas-mitmproxy restart
fi
