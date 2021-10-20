# UCI configuration helper functions

# Currently configured brightness level
brightness() { 
	if [ "${1:-}" = "fetch" ] || [ -z "${brightness:-}" ]; then
		__brightness="$(uci -q get "rainbow.all.brightness" || echo 255)"
		if [ "$__brightness" -lt 0 ] || [ "$__brightness" -gt 255 ]; then
			__brightness=255
		fi
	fi
	echo "$__brightness"
}

# Set the new brightness level
update_brightness() {
	local brightness="$1"
	# We try to be clever here. We want to store brightness to UCI so we are
	# consistent (no external file) but we do not want to cause byte moves,
	# we want to only rewrite bytes so we always use three digits.
	uci set "rainbow.all=led"
	uci set "rainbow.all.brightness=$(printf '%03d' "$brightness")"
	uci commit rainbow.all.brightness
}


# Extract base configuration (level 0) from UCI
base_config() {
	[ "${_base_config_updated:-}" != "y" ] || return 0
	loadsrc animation
	# The subshell here is used to hide function.sh
	(
		set +u # functions.sh does not support unset variables being error
		. /lib/functions.sh

		config_load rainbow
		default_r=255 default_g=255 default_b=255
		default_mode="auto" default_mode_args=""
		_uci_rainbow_section "all"
		default_r="$color_r" default_g="$color_g" default_b="$color_b"
		default_mode="$mode" default_mode_args="$mode_args"
		for led in $LEDS; do
			_uci_rainbow_section "$led"
			echo "$color_r	$color_g	$color_b	$mode${mode_args:+ }$mode_args"
		done >"$rainbowdir/000-base"

		config_load system
		for led in $LEDS; do
			color_r="-" color_g="-" color_b="-" mode="-" mode_args=""
			sysfs="$(led2sysfs "$led")"; sysfs="${sysfs##*/}"
			config_foreach _uci_system_section "led"
			echo "$color_r	$color_g	$color_b	$mode${mode_args:+ }$mode_args"
		done >"$rainbowdir/000-system"
	)
	_base_config_updated="y"
}

# Parse given led setting from UCI
_uci_rainbow_section() {
	local led="$1"
	color_r="$default_r" color_g="$default_g" color_b="$default_b"
	mode="$default_mode" mode_args="$default_mode_args"
	! type led_defaults >/dev/null || led_defaults "$led"

	config_get rawcolor "$led" "color" ""
	parse_color "$rawcolor"

	config_get rawmode "$led" "state" "" # backward compatibility
	config_get rawmode "$led" "mode" "$rawmode"
	[ -n "$rawmode" ] || return 0
	mode="$rawmode"
	mode_args=""
	if [ "$mode" = "activity" ]; then
		config_get trigger "$led" "trigger" "activity"
		mode_args="$trigger"
	elif [ "$mode" = "animate" ]; then
		local animation animation_color_r animation_color_g animation_color_b
		animation_init
		config_list_foreach "$led" "$animation" _for_uci_animation
		animation_finish
		mode_args="$animation"
	fi
}

_for_uci_animation() {
	local value="$1"
	read -r color time <<-EOF
		$value
	EOF
	animation_add "$color" "$time" \
		|| warning "Skipping invalid animation state for '$led': $1"
}

_uci_system_section() {
	local section="$1"
	local cursysfs
	config_get cursysfs "$section" "sysfs"
	if [ "$cursysfs" = "$sysfs" ]; then
		local default trigger
		config_get_bool default "$section" "default" "0"
		config_get trigger "$section" "trigger" "none"
		case "$trigger" in
			none)
				[ "$default" != "1" ] \
					|| mode="enable"
				;;
			time)
				local on off
				config_get on "$section" "delayon"
				config_get off "$section" "delayoff"
				if [ -n "$on" ] && [ -n "$off" ]; then
					mode="animate"
					mode_args="black	$off	black	0	-	$on	-	0"
				fi
				;;
			default-on)
				mode="enable"
				;;
			heatbeat)
				mode="activity"
				if [ "$default" = "0" ]; then
					mode_args="heatbeat"
				else
					mode_args="heatbeat-inverted"
				fi
				;;
			netdev)
				local dev
				config_get dev "$section" "dev"
				if [ -n "$dev" ]; then
					mode="activity"
					mode_args="netdev-$dev"
				fi
				# We ignore mode as rainbow does not support it
				;;
			phy*)
				mode="activity"
				mode_args="${trigger%${trigger#phy[0-9]}}"
				;;
			usbdev|usbport)
				mode="activity"
				mode_args="usbport"
				# We ignore dev as rainbow simply follows all USB devices
				;;
			*)
				warning "Unsupported trigger '$trigger' for: system.$section ($sysfs)"
				;;
		esac
	fi
}
