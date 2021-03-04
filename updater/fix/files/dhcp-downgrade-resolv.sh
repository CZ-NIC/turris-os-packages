#!/bin/sh
set -e
. /lib/functions.sh
. /lib/config/uci.sh

config_load dhcp

dhcp_resolv_downgrade() {
	local conf="$1"
	local option="resolvfile"
	local val
	local new_val
	local old_val

	new_val="/tmp/resolv.conf.d/resolv.conf.auto"
	old_val="/tmp/resolv.conf.auto"
	config_get val "$conf" "$option"

	if [ "$val" = "$new_val" ]; then
		uci set dhcp.$conf.resolvfile="$old_val"
		uci commit dhcp
	fi
}

config_foreach dhcp_resolv_downgrade dnsmasq
