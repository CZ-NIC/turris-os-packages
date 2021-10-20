led_activity_usage() {
	echo "Usage: $0 $1 activity [OPTION].. [TRIGGER]" >&2
}
led_activity_help() {
	led_usage "$1"
	cat >&2 <<-EOF
		Led mode '$1' that blinks with specific device activity.

		Options:
		  -l  List available activity triggers for this led and exit
		  -h  Print this help text and exit
	EOF
}

op_led_activity() {
	local id="$1"; shift
	local list="n"
	while getopts "t:lih" opt; do
		case "$opt" in
			l)
				list="y"
				;;
			h)
				led_activity_help "$id"
				exit 0
				;;
			*)
				led_activity_usage "$id"
				exit 2
				;;
		esac
	done
	shift $((OPTIND - 1))

	if [ "$list" = "y" ]; then
		all_supported_activities "$id"
		exit 0
	fi

	# Note: we do not support every single activity trigger. For example we only
	# support trigger that do both TX and RX not the separate ones.
	# Warning: this sets mode_args as this is expected to be called only from
	# op_led function!
	mode_args=""
	case "${1:-}" in
		"")
			mode_args="activity"
			shift || true
			;;
		activity|activity-inverted|heartbeat|heatbeat-inverted|disk-activity|usbport)
			mode_args="$1"
			shift
			;;
		activity-inverted|heartbeat-inverted)
			;;
		netdev-*)
			# We do not intentionally verify that device exists as this way the
			# hotplug devices can be configured as well.
			mode_args="netdev\t${1#netdev-}"
			shift
			;;
		mmc*|phy*|ata*|netfilter-*)
			[ -n "$(supported_activities "$id" -xF "$1")" ] || {
				echo "The requested activity is invalid: $1" >&2
				usage
				exit 2
			}
			mode_args="$1"
			shift
			;;
	esac
	SHIFTARGS=$#
}

# Provide supported activities that are filtered using grep
supported_activities() {
	local led
	led="$(canonled "$1")"; shift
	if [ "$led" = "all" ]; then
		for led in $LEDS; do
			supported_activities "$led" "$@" \
				| sort -u
		done
	else
		tr ' ' '\n' <"$(led2sysfs "$led")/trigger" \
			| grep "$@" || true
	fi
}

# Lists all supported activities for given led.
all_supported_activities() {
	local led
	led="$(canonled "$1")"
	supported_activities "$led" -xF "activity" \
		&& echo "activity-inverted"
	supported_activities "$led" -xF "heartbeat" \
		&& echo "heartbeat-inverted"
	supported_activities "$led" \
		-E "^(disk-activity|usbport|(mmc|ata)[0-9]+|netfilter-.*)$"
	supported_activities "$led" -E "^phy[0-9]+tpt$" | sed 's/tpt$//'
	if [ -n "$(supported_activities "$led" -E "netdev")" ]; then
		for netdev in /sys/class/net/*; do
			[ -e "$netdev" ] || continue
			echo "netdev-${netdev##*/}"
		done
	fi
}

# Check if activities are even supported for given led.
led_activities_supported() {
	type led2sysfs >/dev/null || return
	local led="$1"
	# The activities are supported only if we have kernel driver and that 
	if [ "$led" = "all" ]; then
		for led in $LEDS; do
			# We report that at least one led supports it here
			led_activities_supported "$led" && return
		done
	else
		led="$(canonled "$led")"
		led2sysfs "$led" >/dev/null \
			&& [ -n "$(all_supported_activities "$led")" ]
	fi
}


# This function applies activity trigger to led. This is kind of non-standard as
# this is called from backend.sh (from set_led) but this is same for any
# activity capable led.
apply_activity() {
	local led="$1"; shift
	local trigger="${1:-}"
	local sysfs
	sysfs="$(led2sysfs "$led")"
	case "$trigger" in
		activity|activity-inverted|heartbeat|heatbeat-inverted)
			local systrigger="${trigger%-inverted}"
			echo "$systrigger" >"$sysfs/trigger"
			grep -qF "[$systrigger]" "$sysfs/trigger"
			if [ "${trigger%-inverted}" == "$trigger" ]; then
				echo "0" >"$sysfs/invert"
			else
				echo "1" >"$sysfs/invert"
			fi
			;;
		disk-activity|mmc*|ata*|netfilter-*)
			echo "$trigger" >"$sysfs/trigger"
			grep -qF "[$trigger]" "$sysfs/trigger"
			;;
		usbport)
			echo "$trigger" >"$sysfs/trigger"
			grep -qF "[$trigger]" "$sysfs/trigger" || return
			for port in "$sysfs"/ports/*; do
				echo 1 > "$port"
			done
			;;
		phy*)
			echo "${trigger}tpt" >"$sysfs/trigger"
			grep -qF "[${trigger}tpt]" "$sysfs/trigger"
			;;
		netdev-*)
			echo "netdev" >"$sysfs/trigger"
			grep -qF '[netdev]' "$sysfs/trigger" || return
			echo "${trigger#netdev-}" >"$sysfs/device_name"
			echo 1 >"$sysfs/link"
			echo 1 >"$sysfs/rx"
			echo 1 >"$sysfs/tx"
			;;
		*)
			internal_error "Unsupported activity arguments:" "$trigger"
			;;
	esac
}
