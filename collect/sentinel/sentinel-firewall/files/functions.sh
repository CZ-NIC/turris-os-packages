#!/bin/sh
## sentinel-firewall.sh
#
# set of firewall rules handling functions intended to be sourced and reused
# in sentinel-related scripts

# source OpenWrt functions if not sourced yet
command -v config_load > /dev/null || . /lib/functions.sh


# This function enables given option on firewall zone wan unless it is already set
# to some value.
# option: option name to enable
config_firewall_default_enable() (
	local option="$1" # This is used inside __enable_on_wan_zone
	config_load "firewall"
	config_foreach __enable_on_wan_by_default "zone"
	[ -z "$(uci changes firewall)" ] || \
		uci commit firewall
)

__enable_on_wan_by_default() {
	local section="$1"
	local zone_name
	config_get zone_name "$section" "name"
	[ "$zone_name" = "wan" ] || return 0

	local enabled
	config_get_bool enabled "$section" "$option" ""
	[ -n "$enabled" ] || \
		uci -q set "firewall.$section.$option=1"
}
