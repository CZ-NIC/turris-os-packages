# State directory helper functions

# Parses stdin where it expects to get lines for leds. The provided function is
# called with provided arguments.
# The function provides variables:
# led: with led name (from LEDS list)
# color_r: 0-255 value of red color
# color_g: 0-255 value of green color
# color_b: 0-255 value of blue color
# mode: mode of led
# mode_args: Any argument passed after mode (which are mode arguments)
# It echoes the possibly updated state after function call (feel free to discart
# output if you do not update variables).
parse_leds_file() {
	local func="$1"; shift
	local led
	for led in $LEDS; do
		local color_r="-" color_g="-" color_b="-" mode="-" mode_args
		read -r color_r color_g color_b mode mode_args
		"$func" "$@" </dev/null >&2
		printf "%s\t%s\t%s\t%s" "$color_r" "$color_g" "$color_b" "$mode"
		[ -n "$mode_args" ] \
			&& printf "\t%s" "$mode_args"
		printf "\n"
	done
}

# Call provided function with configuration for specified priority.
# The provided variables are the same as parse_leds_file and their modification
# is saved back to the file.
call_for_leds_config_level() {
	local priority="$1"
	local slot="$2"
	local fnc="$3"
	shift 3
	local file="$rainbowdir/$(printf "%03d" "$priority")-$slot"
	{
		if [ -f "$file" ]; then
			cat "$file"
		else
			for led in $LEDS; do
				printf -- "-\t-\t-\t-\n"
			done
		fi
	} | parse_leds_file "$fnc" "$@" > "$file.new"
	if grep -qv '^-\t-\t-\t-' "$file.new"; then
		mv "$file.new" "$file"
	else
		# The configuration is empty so we no longer need it
		rm -f "$file" "$file.new"
	fi
}

# Calls provided function with assembled configuration (combination of all
# configured levels). The provided variables are the same as parse_leds_file.
call_for_leds_config() {
	local fnc="$1"; shift
	awk -F'\t' '
		{
			for (i=1; i<=NF; i++)
				if (fields[FNR,i] == "" || $i != "-")
					fields[FNR,i]=$i
		}
		END {
			OFS="\t"
			for (x = 1; x <= FNR; x++) {
				$0=""
				y = 1
				while ((x,y) in fields)
					$y=fields[x,y++]
				print
			}
		}
	' "$rainbowdir"/[0-9][0-9][0-9]-* \
		| parse_leds_file "$fnc" "$@" >/dev/null
}
