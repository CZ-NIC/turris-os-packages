#!/bin/sh
set -eu

cd "/etc/rc.d"

# Remove any dangling links
for rc in *; do
	[ -L "$rc" ] || continue
	[ -f "$rc" ] || {
		echo "Removing enable for non-existent service: $rc" >&2
		rm -f "$rc"
	}
done

# Fix multiple links for same service
# We list here all links and do two passes. First we just remove number and filter
# out only duplicates. This way we have problematic services but to get name only
# once we have to remove leading 'S' or 'K' and do second pass. This way we have
# just list of all problematic services.
find -maxdepth 1 -type l \
		| sed 's|\./\([SK]\)..|\1|' | sort | uniq -d \
		| sed 's|[SK]||' | sort | uniq \
		| while read -r service; do
	echo "Fixing multiple startup/shutdown links for service: $service" >&2
	rm -f [SK]??"$service"
	"/etc/init.d/$service" enable
done
