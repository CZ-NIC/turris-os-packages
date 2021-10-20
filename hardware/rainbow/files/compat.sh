# These are common arguments that were previously provided by rainbow but are
# now obsolete. They are implemented separately so backend can choose which it
# has to support (depending on rainbow introduction to the platform).

compat_binmask() {
	if [ $# -eq 0 ]; then
		echo "Invalid binmask usage. Missing number."
		exit 2
	fi

	_compat_binmask_modify() {
		[ "$1" != "$led" ] \
			|| mode="$2"
	}

	local binmask="$1"
	shift
	[ "${binmask#0x}" == "$binmask" ] \
		|| binmask="$((16#${binmask#0x}))"

	local mask=1
	for led in $LEDS; do
		mask=$((mask << 1))
	done

	for led in $LEDS; do
		mask=$((mask >> 1))
		local mode="disable"
		[ "$((binmask & mask))" -eq 0 ] \
			|| mode="enable"
		call_for_leds_config_level "$priority" "$slot" _compat_binmask_modify \
			"$led" "$mode"
	done
	apply_needed="y"
	SHIFTARGS=$#
}


compat_intensity() {
	local max="$1"; shift
	if [ $# -gt 0 ]; then
		loadsrc uci
		update_brightness "$(($1 * 255 / max))"
		apply_needed="y"
		shift
	else
		echo "Invalid intensity usage. Missing intensity value." >&2
		exit 2
	fi
	SHIFTARGS=$#
}


compat_get() {
	local max="$1"; shift
	if [ "${1:-}" = "intensity" ]; then
		echo "$(($2 * max / 255))"
		shift 2
	else
		echo "Invalid get usage. Missing 'intensity' argument." >&2
		exit 2
	fi
	SHIFTARGS=$#
}
