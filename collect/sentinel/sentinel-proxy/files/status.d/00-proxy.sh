#!/bin/sh
set -e
. "${0%/*}/common.sh"
. /lib/functions/sentinel.sh


if service_is_running "sentinel-proxy"; then
	state="$RUNNING"
	# TODO check if proxy is connected to the Sentinel server
else
	agreed_with_eula 2>/dev/null \
		&& state="$FAILED" \
		|| state="$DISABLED"
fi

echo_res "Server Connection" "$state"
