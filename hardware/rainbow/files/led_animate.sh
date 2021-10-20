loadsrc animation

led_animate_usage() {
	echo "Usage: $0 $1 animate [OPTION].. [COLOR TIME].." >&2
}
led_animate_help() {
	led_usage "$1"
	cat >&2 <<-EOF
		Led mode for '$1' that autonomously changes color based on pattern.
		The pattern is combination of color and time. The time is in
		miliseconds. The color is of the same format as when led color is being
		specified. This includes the inheritence which refers to the color of
		led outside of the animation.

		Options:
		  -h  Print this help text and exit
	EOF
}

op_led_animate() {
	local id="$1"; shift
	while getopts "h" opt; do
		case "$opt" in
			h)
				led_animate_help "$id"
				exit 0
				;;
			*)
				led_animate_usage "$id"
				exit 2
				;;
		esac
	done
	shift $((OPTIND - 1))

	local animation
	parse_animation "$@"
	shift $(($# - SHIFTARGS))
	mode_args="$animation"

	SHIFTARGS=$#
}
