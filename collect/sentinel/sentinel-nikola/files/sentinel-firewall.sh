#!/bin/sh
set -e
. "${0%/*}/common.sh"
. /lib/functions.sh


nikola_logging() {
	local config_section="$1"
	local zone enabled
	config_get zone "$config_section" "name"
	config_get_bool enabled "$config_section" "sentinel_fwlogs" "0"
	[ "$enabled" = "1" ] || return 0

	report_operation "Logging of zone '$zone'"
	for fate in DROP REJECT; do
		local chain="zone_${zone}_src_${fate}"
		iptables_chain_exists "$chain" || continue
		report_info "$fate"
		iptables -I "$chain" 1 \
			-m limit --limit 500/sec \
			-m comment --comment "!sentinel: Nikola" \
			-j LOG --log-prefix "$fate $zone in: "
	done
}

config_load "firewall"
config_foreach nikola_logging "zone"
