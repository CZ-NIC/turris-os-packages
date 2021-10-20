# Canonize color to RGB 0-255 format.
# Sets three variables: color_r, color_g, color_b
parse_color() {
	local r="" g="" b=""
	_parse_color "$@" || return
	[ -z "$r" ] || color_r="$r"
	[ -z "$g" ] || color_g="$g"
	[ -z "$b" ] || color_b="$b"
}

_parse_value() {
	local value="$1"
	local mode="$2"
	[ "${value#x}" == "$value" ] \
		|| value="$((16#${value#x}))"

	if [ "$mode" = "inherit" ] && [ "$value" = "-" ]; then
		true
	elif [ -n "$value" ]; then
		echo "$value" | grep -qE "^[0-9]*$" || return
		[ "$value" -ge 0 ] || return
		[ "$value" -le 255 ] || return
	fi

	echo "$value"
}

_parse_color() {
	local value="$1"
	local mode="${2:-}"

	if [ -z "$value" ]; then
		return # Empty value means no modification
	fi

	case "$value" in
		-)
			if [ "$mode" = "inherit" ]; then
				r="-" g="-" b="-"
				return
			fi
			;;
		red)
			r=255 g=0 b=0
			return
			;;
		green)
			r=0 g=255 b=0
			return
			;;
		blue)
			r=0 g=0 b=255
			return
			;;
		yellow)
			r=255 g=255 b=0
			return
			;;
		cyan)
			r=0 g=255 b=255
			return
			;;
		magenta)
			r=255 g=0 b=255
			return
			;;
		white)
			r=255 g=255 b=255
			return
			;;
		black)
			r=0 g=0 b=0
			return
			;;
	esac

	if echo "$value" | grep -qE "^[0-9-]*,[0-9-]*,[0-9-]*$"; then
		matched="y"
		r="$(_parse_value "${value%%,*}" "$mode")" || return
		local inter="${value%,*}"
		g="$(_parse_value "${inter#*,}" "$mode")" || return
		b="$(_parse_value "${value##*,}" "$mode")" || return
		return
	fi

	if echo "$value" | grep -qE "^[RGB]([0-9]+|x[0-9a-fA-F]+)(,[RGB]([0-9]+|x[0-9a-fA-F]+))*$"; then
		matched="y"
		while read -r spec; do
			case "$spec" in
				R*)
					r="$(_parse_value "${spec#R}" "$mode")" || return
					;;
				G*)
					g="$(_parse_value "${spec#G}" "$mode")" || return
					;;
				B*)
					b="$(_parse_value "${spec#B}" "$mode")" || return
					;;
			esac
		done <<-EOF
			$(echo "$value" | tr ',' '\n')
		EOF
		return
	fi

	# Hex format for backward compatibility
	if echo "$value" | grep -qE "^[0-9a-fA-F]{6}$"; then
		r="$(_parse_value "x${1:0:2}" "")" || return
		g="$(_parse_value "x${1:2:2}" "")" || return
		b="$(_parse_value "x${1:4:2}" "")" || return
		return
	fi

	return 1
}
