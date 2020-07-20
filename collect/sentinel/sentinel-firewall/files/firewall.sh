#!/bin/sh
# This script is intended to be called from firewall3 as a hook.
# Make sure that you have following section at the end of /etc/config/firewall:
#   config include 'sentinel_firewall'
#		option type 'script'
#		option path '/usr/libexec/sentinel/firewall.sh'
#		option family 'any'
#		option reload '1'


# Remove any existing rule
# (firewall3 removes only rules in chains it knows so we have to do this to
# potentially clean after ourselves)
for table in filter nat mangle raw; do
	iptables -t "$table" -S \
		| grep -F ' --comment "!sentinel:' \
		| while read -r operation rule; do
			# Argument -A is dropped (variable 'operation' is intentionally left out)
			# Note: xargs is used here because it handles quotes properly over
			# just plain expansion
			echo "$rule" | xargs -x iptables -t "$table" -D
		done
done


# Run all sentinel firewall scripts
cd /usr/libexec/sentinel/firewall.d
for module in ./*; do
	[ -x "$module" ] || continue
	"$module"
done
