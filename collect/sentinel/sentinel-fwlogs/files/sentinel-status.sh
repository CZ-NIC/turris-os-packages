#!/bin/sh
set -e
. "${0%/*}/common.sh"
. /lib/functions/sentinel.sh


if service_is_running "sentinel-fwlogs"; then
	state="$RUNNING"
	# TODO check if connected to proxy
else
	allowed_to_run "fwlogs" 2>/dev/null \
		&& state="$FAILED" \
		|| state="$DISABLED"
fi

echo_res "FWLogs" "$state"
