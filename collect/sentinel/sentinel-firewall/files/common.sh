# These are common helpers for sentinel-firewall scripts.

report_operation() {
	echo "   *" "$@" >&2
}

report_info() {
	echo "     -" "$@" >&2
}

# This exits with non-zero exit code if argument can't be sourced and with zero
# exit code if sourced
source_if_exists() {
	[ -f "$1" ] && source "$1"
}

# This is simple helper to check for existence of given chain
iptables_chain_exists() {
	iptables -S "$1" >/dev/null 2>&1
}

# Add drop rule
# zone: name of firewall zone incoming packets are coming from
# chain: chain to be affected (input/forward)
# Any additional arguments are passed to iptables call adding this rule
iptables_drop() {
	local zone="$1"
	local chain="$2"
	shift 2
	local drop_zone="zone_${zone}_src_DROP"

	# fw3 won't create chain for drop if no rule in UCI requires it. This just
	# recreates it if it is missing.
	if ! iptables_chain_exists "$drop_zone"; then
		iptables -N "$drop_zone"
		iptables -A "$drop_zone" \
			-m comment --comment "!sentinel" \
			-j DROP
	fi

	iptables -I "zone_${zone}_${chain}" 1 "$@" -j "$drop_zone"
}

# Add port redirect rule.
# zone: name of firewall zone incoming packets are coming from
# port: target port of packet
# local_port: local port to redirect packet to
# description: description for this redirect printed and recorded in comment
iptables_redirect() {
	local zone="$1"
	local port="$2"
	local local_port="$3"
	local description="$4"

	report_operation "$description on zone '$zone' ($port -> $local_port)"
	iptables -t nat -A "zone_${zone}_prerouting" \
		-p tcp \
		-m tcp --dport "$port" \
		-m comment --comment "!sentinel: $description port redirect" \
		-j REDIRECT --to-ports "$local_port"
}
