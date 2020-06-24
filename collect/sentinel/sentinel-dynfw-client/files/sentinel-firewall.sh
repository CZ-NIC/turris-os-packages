#!/bin/sh
set -e
. "${0%/*}/common.sh"
. /lib/functions.sh


dynfw_block() {
	local config_section="$1"
	local zone enabled
	config_get zone "$config_section" "name"
	config_get_bool enabled "$config_section" "sentinel_dynfw" "0"
	[ "$enabled" = "1" ] || return 0

	report_operation "Dynamic blocking on zone '$zone'"
	for chain in input forward; do
		local chain_enabled
		config_get_bool chain_enabled "$config_section" "sentinel_dynfw_${chain}" "1"
		[ "$chain_enabled" = "1" ] || continue
		report_info "$chain"
		iptables_drop "${zone}" "${chain}" \
			-m set --match-set 'turris-sn-dynfw-block' src \
			-m mark ! --mark '0x10/0x10' \
			-m conntrack --ctstate NEW \
			-m comment --comment "!sentinel: dynamic firewall block"
	done
}

config_load "firewall"
config_foreach dynfw_block "zone"
