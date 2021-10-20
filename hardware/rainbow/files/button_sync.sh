#!/bin/sh
set -eu
. "$(dirname "$(readlink -f "$0")")/utils.sh"

loadsrc backend
loadsrc state

type get_brightness >/dev/null \
	|| fail "Button sync is not supported on this board!"


trap 'exit 0' INT QUIT TERM
while true; do
	# TODO we might race here with rainbow configuration (uci changes but change
	# is not yet propagated). It is very unlikelly but probably possible.
	current_brightness="$(get_brightness)"
	if [ "$(brightness fetch)" != "$current_brightness" ]; then
		echo "Brightness update using button to: $current_brightness"
		update_brightness "$current_brightness"
	fi
	sleep 2
done
