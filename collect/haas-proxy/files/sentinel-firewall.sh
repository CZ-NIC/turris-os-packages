#!/bin/sh
set -e
SF_DIR="${0%/*}"
. "$SF_DIR/common.sh"
. /lib/functions.sh


config_load "haas"
config_get local_port "settings" "local_port" "2525"


port_redirect_zone() {
	local config_section="$1"
	local zone enabled
	config_get zone "$config_section" "name"
	config_get_bool enabled "$config_section" "haas_proxy" "0"
	[ "$enabled" = "1" ] || return 0

	iptables_redirect "$zone" 22 "$local_port" "HaaS proxy"
}

config_load "firewall"
config_foreach port_redirect_zone "zone"


if source_if_exists "$SF_DIR/dynfw-utils.sh"; then
	bypass_dynamic_firewall "tcp" "22" "HaaS proxy"
fi
