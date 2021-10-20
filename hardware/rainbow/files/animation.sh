loadsrc color

# Initialize animation variables
# Yes yes this is not nice as it uses global variables but iterative addition is
# the easies API considering the usage in uci.sh that I could come up with.
animation_init() {
	animation=""
	animation_color_r="?"
	animation_color_g="?"
	animation_color_b="?"
}

animation_add() {
	local color="$1"
	local time="$2"
	local color_r="$animation_color_r"
	local color_g="$animation_color_g"
	local color_b="$animation_color_b"

	parse_color "$1" inherit || return
	echo "$time" | grep -qE "^[0-9]+$" || return

	animation="${animation}${animation:+	}$color_r	$color_g	$color_b	$time"
	animation_color_r="$color_r"
	animation_color_g="$color_g"
	animation_color_b="$color_b"
}

animation_finish() {
	if [ -n "$animation" ]; then
		# The magic in the awk is that question mark is used only for values
		# from initial steps and never after if there was some other value. This
		# means that we can replace any occurrences of it by values from last
		# state. The exception is when value was never specified, then the
		# default that is inheritance is used.
		animation="$(echo "$animation" | awk -F'\t' '{
			OFS="\t"
			for (i = 0; i < 4; i++) {
				c[i] = $(NF - 3 + i)
				if (c[i] == "?")
					c[i] = "-"
			}
			for (i = 1; i <= NF; i++)
				if ($i == "?")
					$i = c[(i - 1) % 4]
			print
		}')"
	fi
}

# Load animation sequence and format it to internal representation.
# Arguments are expected to be pairs of color and time. The result is saved to
# the animation variable.
# The number of consumed arguments is signaled by setting SHIFTARGS to the $#.
parse_animation() {
	# Explanation about magic here..
	# The animation is sequence of values that repeats for inifinity. This means
	# that color in next step modifies the previous one and the first one
	# modifies the last one. As an example let's take sequence:
	#  R255 100 R0 100 G255 100 G0 100
	# In this sequence the initial two states do not specify green color but
	# from sequence it is clear that it should be zero. The same applies for the
	# red color in last two states.
	# To assemble complete sequence we have to always modify previously
	# specified value. This is achieved simply by updating previous color. The
	# issue is that for initial steps the previous values are the last ones so
	# we have to read all steps before we can propagate them back.
	# The solution here is to use temporally value for any value we are not sure
	# about and fill it later on when we read all arguments.
	local animation_color_r animation_color_g animation_color_b
	animation_init
	# We always parse two arguments at once (color and time)
	while [ $# -ge 2 ]; do
		animation_add "$1" "$2" || break
		shift 2
	done
	animation_finish
	SHIFTARGS=$#
}
