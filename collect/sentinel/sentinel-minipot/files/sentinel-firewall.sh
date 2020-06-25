#!/bin/sh
set -e
SF_DIR="${0%/*}"
. "$SF_DIR/common.sh"
. /lib/functions.sh
. /lib/functions/sentinel.sh

allowed_to_run "minipot" 2>/dev/null || return 0


config_load "sentinel"
config_get telnet_port "minipot" "telnet_port" "2333"


port_redirect_zone() {
	local config_section="$1"
	local zone enabled
	config_get zone "$config_section" "name"
	config_get_bool enabled "$config_section" "sentinel_minipot" "0"
	[ "$enabled" = "1" ] || return 0

	[ "$telnet_port" = "0" ] || \
		iptables_redirect "$zone" 23 "$telnet_port" "Minipot Telnet"
}

config_load "firewall"
config_foreach port_redirect_zone "zone"


if source_if_exists "$SF_DIR/dynfw-utils.sh"; then
	[ "$telnet_port" = "0" ] || \
		bypass_dynamic_firewall "tcp" "23" "Minipot Telnet"
fi
