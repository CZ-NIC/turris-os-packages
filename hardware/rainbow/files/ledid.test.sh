#!/bin/ash
set -eu
. "${0%/*}/ledid.sh"

fail() {
	echo "$@" >&2
	exit 1
}

LEDS="pwr lan0 lan1 pci1 usr1"

valid() {
	is_valid_led "$1" || fail "Led should be valid but it is not: $1"
}

not_valid() {
	! is_valid_led "$1" || fail "Led should not be valid but it is: $1"
}

for led in $LEDS; do
	valid "$led"
done
not_valid "power"
not_valid "usr"
not_valid "p"
not_valid "1"

for i in $(seq 5); do
	valid "led$i"
done
not_valid "led6"
not_valid "led7"


canon() {
	local value="$1"
	local expected="$2"
	local res
	res="$(canonled "$value")" || fail "Led canon failed for: $value"
	[ "$res" = "$expected" ] || fail "Led canon is not correct: $res != $expected"
}

index=1
for led in $LEDS; do
	canon "$led" "$led"
	canon "led$index" "$led"
	index=$((index + 1))
done
canon "foo" "foo"
