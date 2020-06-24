#!/bin/sh
cd /usr/libexec/sentinel/firewall.d
for module in ./*; do
	[ -x "$module" ] || continue
	"$module"
done
