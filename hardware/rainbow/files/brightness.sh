loadsrc uci

brightness_usage() {
	echo "Usage: $0 brightness [OPTION].. <VALUE>" >&2
}
brightness_help() {
	brightness_usage
	# Note: We use 0-8 as that is the number of levels Omnia can specify using
	# button. The Turris 1.x has only 7 levels but we can use 7 and 8 as the
	# same. The Mox has no levels thus we are free to choose what ever we want.
	cat >&2 <<-EOF
		Set maximum brightness (the global modifier for all controlled leds).
		The brightness has to be specified as number between 0 and 8 (or 255
		if -p is used).

		Options:
		  -q  Query for current setting instead of setting brightness
		  -p  Higher precission for brightness
		  -h  Print this help text and exit
	EOF
}

op_brightness() {
	local query="f"
	local precise="n"
	while getopts "qh" opt; do
		case "$opt" in
			q)
				query="y"
				;;
			p)
				precise="y"
				;;
			h)
				brightness_help
				exit 0
				;;
			*)
				brightness_usage
				exit 2
				;;
		esac
	done
	if [ "$query" = "y" ]; then
		brightness fetch
		return $#
	fi

	shift $((OPTIND - 1))
	[ $# -gt 0 ] || {
		brightness_usage
		exit 2
	}
	brightness="$1"
	if [ "$precise" = "y" ]; then
		if [ "$brightness" -lt 0 ] || [ "$brightness" -gt 255 ]; then
			echo "The value has to be a number from 0 to 255!" >&2
			brightness_usage
			exit 2
		fi
	else
		if [ "$brightness" -lt 0 ] || [ "$brightness" -gt 8 ]; then
			echo "The value has to be a number from 0 to 8!" >&2
			brightness_usage
			exit 2
		fi
		brightness=$((brightness * 32))
	fi
	update_brightness "$brightness"
	apply_needed="y"

	SHIFTARGS=$#
}
