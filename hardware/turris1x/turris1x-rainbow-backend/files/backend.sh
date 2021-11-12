# Turris 1.x backend for generic rainbow script
LEDS="wan lan1 lan2 lan3 lan4 lan5 wifi pwr"

led_defaults() {
	local led="$1"
	case "$led" in
		pwr)
			color_r=0 color_g=255 color_b=0
			;;
		lan*|wifi)
			color_r=0 color_g=0 color_b=255
			;;
		wan)
			color_r=0 color_g=255 color_b=255
			;;
	esac
}

get_brightness() {
	local cur
	cur="$(turris1x-rainbow get intensity)"
	echo $((cur * 255 / 7))
}

preapply() {
	/etc/init.d/rainbow-animator pause

	local brightness_level
	brightness_level="$(brightness)"
	# TODO we might want to use brightness of leds to tweak brightness itself
	turris1x_rainbow_args="intensity $((brightness_level * 7 / 255))"
}

set_led() {
	local led="$1" r="$2" g="$3" b="$4" mode="$5"
	shift 5

	turris1x_rainbow_args="${turris1x_rainbow_args}${turris1x_rainbow_args:+ }$led"

	turris1x_rainbow_args="${turris1x_rainbow_args} $(printf "%.2X%.2X%.2X" "$r" "$g" "$b")"

	case "$mode" in
		auto|disable|enable)
			turris1x_rainbow_args="${turris1x_rainbow_args} $mode"
			;;
		animate)
			turris1x_rainbow_args="${turris1x_rainbow_args} enable"
			# For animation we we rely on animator
			;;
		*)
			internal_error "Unsupported mode:" "$mode"
			;;
	esac
}

postapply() {
	[ -z "$turris1x_rainbow_args" ] \
		|| turris1x-rainbow $turris1x_rainbow_args
	/etc/init.d/rainbow-animator reload
}


boot_sequence() {
	turris1x-rainbow all green enable
	sleep 1
	turris1x-rainbow all blue enable
	sleep 1
	# Note: we apply in the end so we don't have to restore previous state
}


# Parse operations that were previously available with rainbow
compatibility() {
	local operation="$1"; shift
	SHIFTARGS=$#
	case "$operation" in
		binmask)
			compat_binmask "$@"
			;;
		intensity)
			compat_intensity 7 "$@"
			;;
		get)
			compat_get 7 "$@"
			;;
	esac
	shift $(($# - SHIFTARGS))
	SHIFTARGS=$#
}
