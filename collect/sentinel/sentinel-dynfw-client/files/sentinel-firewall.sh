#!/bin/sh
set -e
. "${0%/*}/common.sh"
. /lib/functions.sh

IPSET="turris-sn-dynfw-block"

# Always create IP set to prevent iptables error about missing ipset.
ipset create "$IPSET" hash:ip -exist

dynfw_block() {
	local config_section="$1"
	local zone enabled
	config_get zone "$config_section" "name"
	config_get_bool enabled "$config_section" "sentinel_dynfw" "0"
	[ "$enabled" = "1" ] || return 0

	report_operation "Dynamic blocking on zone '$zone'"
	for chain in "input" "forward"; do
		local chain_enabled
		config_get_bool chain_enabled "$config_section" "sentinel_dynfw_${chain}" "1"
		[ "$chain_enabled" = "1" ] || continue
		report_info "$chain"

		bypass_mark=""
		[ "${chain}" == "input" ] && bypass_mark="-m mark ! --mark 0x10/0x10"

		iptables_drop "${zone}" "${chain}" \
			-m set --match-set "$IPSET" src \
			${bypass_mark} \
			-m conntrack --ctstate NEW \
			-m comment --comment "!sentinel: dynamic firewall block"
	done
}

config_load "firewall"
config_foreach dynfw_block "zone"
