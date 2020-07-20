#!/bin/sh
comment="!redirect: 192.168.1.1"
chain="zone_lan_prerouting"

# Remove any existing rule
# (firewall3 removes only fules in chains it knows so we have to do this to potentially clean after ourself)
iptables -t nat -S \
	| grep -F " --comment \"$comment\" " \
	| while read -r operation rule; do
		# Operation -A is dropped (variable 'operation' is intentionally left out)
		echo "$rule" | xargs -x iptables -t nat -D
		# Note: xargs is used here because it handles quotes properly over just plain expansion
	done

# Add appropriate redirect rule
if iptables -t nat -S "$chain" >/dev/null 2>&1; then
	iptables -t nat -I "$chain" -m comment --comment "$comment" -d 192.168.1.1 -j REDIRECT
	echo " * Redirecting 192.168.1.1 on lan interface to router"
else
	echo "Warning: There is no zone 'zone_lan_prerouting' (zone 'lan' probably does not exist)"
fi
