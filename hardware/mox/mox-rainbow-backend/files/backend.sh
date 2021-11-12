# Turris Mox backend for generic rainbow script
LEDS="activity"

SYSFS="/sys/class/leds/mox:red:activity"

led2sysfs() {
	local led="$1"
	[ "$led" = "activity" ] || return
	echo "$SYSFS"
}

preapply() {
	# TODO we can use pattern trigger to replace animator
	/etc/init.d/rainbow-animator pause
}

set_led() {
	local led="$1" r="$2" g="$3" b="$4" mode="$5"
	shift 5
	[ "$led" = "activity" ] || return

	if [ "$mode" = "auto" ]; then # override auto mode
		mode="activity"
		mode_args="heartbeat"
	fi
	local global_brightness
	global_brightness="$(brightness)"

	local brightness=255 trigger="none"
	case "$mode" in
		disable)
			brightness=0
			;;
		enable)
			;;
		activity)
			brightness=0
			trigger="activity"
			;;
		animate)
			# For animation we we rely on animator
			;;
		*)
			internal_error "Unsupported mode:" "$mode"
			;;
	esac
	brightness=$(((brightness * global_brightness * r) / (255 * 255)))

	# We have to disable trigger first to make sure that changes are correctly
	# applied and not modified by this in the meantime.
	echo "none" > "$SYSFS/trigger"
	echo "$brightness" > "$SYSFS/brightness"
	if [ "$trigger" = "activity" ]; then
		apply_activity "$led" "$@" \
			|| echo "Warning: activity setup failed for: $led" >&2
	else
		echo "$trigger" > "$SYSFS/trigger"
	fi
}

postapply() {
	/etc/init.d/rainbow-animator reload
}
