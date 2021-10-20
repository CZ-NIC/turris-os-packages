# Check if provided led identifier is valid.
# This covers not only those fron LEDS but also ledX where X is number and all.
is_valid_led() {
	local check_led="$1"
	[ "$check_led" = "all" ] \
		&& return 0
	local i=0
	for led in $LEDS; do
		if [ "$check_led" = "$led" ]; then
			return 0
		fi
		i=$((i + 1))
	done
	if [ "${check_led#led}" != "$check_led" ] \
		&& [ "${check_led#led}" -gt 0 ] && [ "${check_led#led}" -le "$i" ]; then
		return 0
	fi
	return 1
}


# Convert any other representation (current only ledX) to thos from LEDS
# variable or 'all'.
canonled() {
	local value="$1"
	local index=1
	local led
	for led in $LEDS; do
		if [ "$value" = "$led" ] || {
			[ "${value#led}" != "$value" ] && [ "${value#led}" -eq $index ]
		}; then
			echo "$led"
			return
		fi
		index=$((index + 1))
	done
	echo "$value"
}
