# This script is intended to be sourced to sentinel-firewall scripts
# It expects that sentinel-firewall's common.sh is sourced already.

# This adds mangle rule to bypass dynamic firewall. It just marks packet with 0x10
# Arguments:
#  protocol: protocol of packet (tcp or udp)
#  port: target port of traffic
#  name_of_service: this is human readable name of service to use bypass for
bypass_dynamic_firewall() (
	local protocol="$1"
	local port="$2"
	local name_of_service="$3"

	iptables -t mangle -A INPUT \
		-p "$protocol" \
		-m "$protocol" --dport "$port" \
		-m comment --comment "!sentinel: Dynamic firewall bypass for $name_of_service" \
		-j MARK --set-xmark 0x10/0xffffffff
)
# Note: This is not ideal as we are marking all traffic not just the one for
# appropriate interface. It should do no harm and can potentially be in the end
# even faster but is somewhat unexpected when dynamic firewall is not configured
# on interface.
