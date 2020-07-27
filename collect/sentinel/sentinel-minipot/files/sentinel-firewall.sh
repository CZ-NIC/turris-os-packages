#!/bin/sh
set -e
SF_DIR="${0%/*}"
. "$SF_DIR/common.sh"
. /lib/functions.sh
. /lib/functions/sentinel.sh
. /usr/libexec/sentinel/minipot-defaults.sh

allowed_to_run "minipot" 2>/dev/null || return 0


config_load "sentinel"
config_get ftp_port "minipot" "ftp_port" "$DEFAULT_FTP_PORT"
config_get http_port "minipot" "http_port" "$DEFAULT_HTTP_PORT"
config_get smtp_port "minipot" "smtp_port" "$DEFAULT_SMTP_PORT"
config_get telnet_port "minipot" "telnet_port" "$DEFAULT_TELNET_PORT"


port_redirect_zone() {
	local config_section="$1"
	local zone enabled
	config_get zone "$config_section" "name"
	config_get_bool enabled "$config_section" "sentinel_minipot" "0"
	[ "$enabled" = "1" ] || return 0

	[ "$ftp_port" = "0" ] || \
		iptables_redirect "$zone" 21 "$ftp_port" "Minipot FTP"
	[ "$http_port" = "0" ] || \
		iptables_redirect "$zone" 80 "$http_port" "Minipot HTTP"
	[ "$smtp_port" = "0" ] || {
		iptables_redirect "$zone" 25 "$smtp_port" "Minipot SMTP"
		iptables_redirect "$zone" 587 "$smtp_port" "Minipot SMTP submission"
	}
	[ "$telnet_port" = "0" ] || \
		iptables_redirect "$zone" 23 "$telnet_port" "Minipot Telnet"
}

config_load "firewall"
config_foreach port_redirect_zone "zone"


if source_if_exists "$SF_DIR/dynfw-utils.sh"; then
	[ "$ftp_port" = "0" ] || \
		bypass_dynamic_firewall "tcp" "21" "Minipot FTP"
	[ "$http_port" = "0" ] || \
		bypass_dynamic_firewall "tcp" "80" "Minipot HTTP"
	[ "$smtp_port" = "0" ] || {
		bypass_dynamic_firewall "tcp" "25" "Minipot SMTP"
		bypass_dynamic_firewall "tcp" "587" "Minipot SMTP submission"
	}
	[ "$telnet_port" = "0" ] || \
		bypass_dynamic_firewall "tcp" "23" "Minipot Telnet"
fi
