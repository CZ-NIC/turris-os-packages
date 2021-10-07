#!/bin/sh
set -e
. "${0%/*}/common.sh"
. /lib/functions/sentinel.sh


if service_is_running "sentinel-minipot"; then
	state="$RUNNING"
	# TODO check if connected to proxy
else
	allowed_to_run "minipot" 2>/dev/null \
		&& state="$FAILED" \
		|| state="$DISABLED"
fi

echo_res "Minipot" "$state"
# TODO every single minipot?
