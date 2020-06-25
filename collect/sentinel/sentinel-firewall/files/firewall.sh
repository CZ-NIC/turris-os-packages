#!/bin/sh
# This script is intended to be called from firewall3 as a hook.
# Make sure that you have following section at the end of /etc/config/firewall:
#   config include 'sentinel_firewall'
#		option type 'script'
#		option path '/usr/libexec/sentinel/firewall.sh'
#		option family 'any'
#		option reload '1'

cd /usr/libexec/sentinel/firewall.d
for module in ./*; do
	[ -x "$module" ] || continue
	"$module"
done
