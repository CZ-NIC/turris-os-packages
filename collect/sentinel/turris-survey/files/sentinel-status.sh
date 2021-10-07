#!/bin/sh
set -e
. "${0%/*}/common.sh"
. /lib/functions/sentinel.sh


allowed_to_run "survey" 2>/dev/null \
	&& state="$RUNNING" \
	|| state="$DISABLED"
# TODO check if there were any data sent trough proxy in day or so

echo_res "Turris Survey" "$state"
