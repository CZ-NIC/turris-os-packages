#!/bin/ash
set -eu
loadsrc() {
	. "${0%/*}/$1.sh"
}
loadsrc animation

fail() {
	echo "$@" >&2
	exit 1
}

check() {
	local seq="$1"
	local residue="$2"
	shift 2
	parse_animation "$@" || fail "Parse failed for: $*"
	[ "$animation" = "$seq" ] || fail "Invalid result '$animation' != '$seq' for: $*"
	[ "$SHIFTARGS" = "$residue" ] || fail "Invalid number of residue for: $*"
}


check "" 0
check \
	"0	0	0	1000	255	0	0	1000" \
	0 \
	black 1000 red 1000
check \
	"255	0	-	1000	0	0	-	1000	0	255	-	1000	0	0	-	1000" \
	0 \
	R255 1000 R0 1000 G255 1000 G0 1000

check "" 2 something else
check \
	"0	0	0	1000	255	0	0	1000" \
	2 \
	black 1000 red 1000 something else
