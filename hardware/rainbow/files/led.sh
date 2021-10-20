loadsrc color
loadsrc ledid

led_usage() {
	echo "Usage: $0 $1 [OPTION].. [COLOR] [MODE]" >&2
}
led_help() {
	led_usage "$1"
	cat >&2 <<-EOF
		Configure '$1'. When no color or mode is given it prints current
		configuration. The output is in tab separated columns with RGB color in
		initial three columns, followed by mode and its arguments.

		Color:
		  Color can be specified by few different ways. You can simply use
		  specific color name (although supported set is small).
		  Another option is to specify RGB compounds. They are integer between 0
		  and 255. They can be specified either in decimal format or in
		  hexadecimal if you prefix it with x (thus xFF is 255). Compounds are
		  expected to be joined by commad (such as 255,0,0 for red). You can
		  also specify compounds out of order by prefixing them with leter R for
		  red, G for green and B for blue (such as G0,B0,R255 for red). Not
		  every color compound has to be defined. They are filled with previous
		  value if you left some out (such as ,255, or G255) or with default
		  '-'. The '-' is the special value that specifies inheritence from
		  lower priority configuration. You can use it as replacement for any
		  color compound or allone to set inheritence.
		Mode:
		  auto
		    Operate led status as designed (that is for example ethernet activity for lan leds)
		  disable
		    Disable led (keep it off)
		  enable
		    Enable led (keep it on)
	EOF
	loadsrc led_activity
	if led_activities_supported "$1"; then
		cat >&2 <<-EOF
		  activity
		    Blink with specific device activity (use -h right after for more info)
		EOF
	fi
	cat >&2 <<-EOF
		  animate
		    Perform specific animation (use -h right after for more info)
		  inherit
		    Inherit status from lower priority level
		  ignore
		    Rainbow should ignore this led all together
		Options:
		  -l  Show configuration only for the current priority and slot
		  -h  Print this help text and exit
	EOF
}

op_led() {
	local id="$1"; shift
	local localconf="n"
	while getopts "lh" opt; do
		case "$opt" in
			l)
				localconf="y"
				;;
			h)
				led_help "$id"
				exit 0
				;;
			*)
				led_usage "$id"
				exit 2
				;;
		esac
	done
	shift $((OPTIND - 1))

	local mode="" mode_args=""
	local color_r="" color_g="" color_b=""
	while [ $# -gt 0 ]; do
		if [ -z "$color_r" ] && [ -z "$color_g" ] && [ -z "$color_b" ]; then
			if parse_color "$1" inherit; then
				shift
				continue
			fi
		fi
		if [ -z "$mode" ]; then
			case "$1" in
				auto|disable|enable|ignore)
					mode="$1"
					shift
					continue
					;;
				activity)
					loadsrc led_activity
					if led_activities_supported "$id"; then
						mode="$1"
						shift
						loadsrc led_activity
						op_led_activity "$id" "$@"
						shift $(($# - SHIFTARGS))
						continue
					fi
					;;
				animate)
					mode="$1"
					shift
					loadsrc led_animate
					op_led_animate "$id" "$@"
					shift $(($# - SHIFTARGS))
					continue
					;;
				inherit)
					mode="-"
					;;
			esac
		fi
		break
	done
	SHIFTARGS=$#

	id="$(canonled "$id")"

	config() {
		if [ "$id" = "all" ] || [ "$led" = "$id" ]; then
			printf "%s\t%s\t%s\t%s\n" "$color_r" "$color_g" "$color_b" \
				"$mode${mode_args:+	}$mode_args" >&2
		fi
	}
	if [ -z "$mode" ] && [ -z "$color_r" ] && [ -z "$color_g" ] && [ -z "$color_b" ]; then
		if [ "$localconf" = "y" ]; then
			call_for_leds_config_level "$priority" "$slot" config
		else
			loadsrc uci
			base_config
			call_for_leds_config config
		fi
		return
	fi

	modify() {
		if [ "$id" = "all" ] || [ "$led" = "$id" ]; then
			[ -z "$1" ] || color_r="$1"
			[ -z "$2" ] || color_g="$2"
			[ -z "$3" ] || color_b="$3"
			[ -z "$4" ] || {
				mode="$4"
				mode_args="$5"
			}
		fi
	}
	call_for_leds_config_level "$priority" "$slot" modify \
		"$color_r" "$color_g" "$color_b" "$mode" "$mode_args"

	apply_needed="y"
}
