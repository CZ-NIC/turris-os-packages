#!/bin/sh
set -eu

rainbowdir="/var/run/rainbow"
mkdir -p "$rainbowdir"
[ "${RAINBOW_DIRECTORY_LOCKED-:}" = "y" ] \
	|| RAINBOW_DIRECTORY_LOCKED="y" exec flock -Fx "$rainbowdir" "$0" "$@"

. "$(dirname "$(readlink -f "$0")")/utils.sh"
loadsrc state
loadsrc ledid
loadsrc backend

################################################################################
usage() {
	echo "Usage: $0 [OPTION].. <OPERATION>..." >&2
}
help() {
	usage
	cat >&2 <<-EOF
		Turris leds manipulation.

		Options:
		  -p INT  Set priority to given led setting (in default 50 is used)
		  -n STR  Slot name ('default' used if not specified)
		  -l      List all available LEDs by name
		  -x      Run in debug mode
		  -h      Print this help text and exit
		Operations:
		  reset  Reset rainbow state (wipe any runtime changes)
		  brightness  Set upper limit on brightness of all leds
		  all  Configure all available leds at once
		  ledX  Where X is number (up to 12 on Omnia and 8 on 1.x)
		  Configure specific led by name:
		    $LEDS
	EOF
}

priority=50
slot="default"
list_leds="n"
while getopts "p:n:lxh" opt; do
	case "$opt" in
		p)
			if [ "$OPTARG" -ge 0 ] && [ "$OPTARG" -le 100 ]; then
				priority="$OPTARG"
			else
				echo "Priority is not in range from 0 to 100: $OPTARG" >&2
				usage
			fi
			;;
		n)
			if [ "${OPTARG#*/}" != "$OPTARG" ]; then
				echo "The slot name can't contain '/'" >&2
				usage
				exit 2
			fi
			slot="$OPTARG"
			;;
		l)
			list_leds="y"
			;;
		x)
			set -x
			;;
		h)
			help
			exit 0
			;;
		*)
			usage
			exit 2
			;;
	esac
done
shift $((OPTIND - 1))

if [ "$list_leds" = "y" ]; then
	for led in $LEDS; do
		echo "$led"
	done
	exit 0
fi

[ $# -gt 0 ] || {
	usage
	exit 2
}

apply_needed="n"
while [ $# -gt 0 ]; do
	operation="${1:-}"
	shift
	case "$operation" in
		reset)
			loadsrc reset
			op_reset "$@"
			shift $SHIFTARGS
			;;
		brightness)
			loadsrc brightness
			op_brightness "$@"
			shift $(($# - SHIFTARGS))
			;;
		"")
			usage
			exit 2
			;;
		*)
			if is_valid_led "$operation"; then
				loadsrc led
				op_led "$operation" "$@"
				shift $(($# - SHIFTARGS))
			else
				SHIFTARGS=$#
				type compatibility >/dev/null \
					&& compatibility "$operation" "$@"
				if [ "$SHIFTARGS" -lt $# ]; then
					shift $(($# - SHIFTARGS))
				else
					echo "Invalid operation: $operation" >&2
					usage
					exit 2
				fi
			fi
			;;
	esac
done

################################################################################
# Helper function that is used in combination with parse_leds_file.
# This takes variables and passes them as an appropriate arguments as set_led
# functions expect it.
call_set_led() {
	[ "$mode" != "ignore" ] || return 0
	shift $# # we do not care about our arguments
	set "$@" "$led" "$color_r" "$color_g" "$color_b" "$mode"
	while read -r arg; do
		set "$@" "$arg"
	done <<-EOF
		$(echo "$mode_args" | tr '\t' '\n')
	EOF
	set_led "$@"
}

loadsrc uci
if [ "$apply_needed" = "y" ]; then
	base_config
	! type preapply >/dev/null || preapply
	call_for_leds_config call_set_led
	! type postapply >/dev/null || postapply
fi
