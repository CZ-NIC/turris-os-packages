#!/bin/sh

HOSTNAME=$(cat /tmp/dhcp.leases | grep $1 | awk '{print $4}')
VENDOR=$(/usr/bin/ouidb $1)
MSG_CZ="Ve vaší síti "; MSG_EN="New device appeared on your "
echo $2 | grep 'guest' >/dev/null 2>&1 && MSG_CZ="$MSG_CZ pro hosty " && MSG_EN="$MSG_EN guest "
MSG_CZ="$MSG_CZ se objevilo nové zařízení (MAC adresa $1"; MSG_EN="$MSG_EN network (MAC address $1"
[ ! -z "$VENDOR" ] && MSG_CZ="$MSG_CZ, výrobce $VENDOR" && MSG_EN="$MSG_EN, vendor $VENDOR"	
[ ! -z "$HOSTNAME" ] && MSG_CZ="$MSG_CZ, hostname $HOSTNAME" && MSG_EN="$MSG_EN, hostname $HOSTNAME"	
MSG_CZ="$MSG_CZ)"; MSG_EN="$MSG_EN)"

/usr/bin/create_notification -s news "$MSG_CZ" "$MSG_EN"
