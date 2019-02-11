#!/bin/ash

#Copyright 2017, CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
#This file is part of foris-ws configuration server.
#
#foris-ws is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#foris-ws is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with foris-ws.  If not, see <http://www.gnu.org/licenses/>.

set -e
exec socat OPENSSL-LISTEN:$2,fork,method=TLS1.2,cert=/etc/lighttpd-self-signed.pem,verify=0,reuseaddr,forever,pf=ip6,ipv6only=0 TCP:0.0.0.0:$1
