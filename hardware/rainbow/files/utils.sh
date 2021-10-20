# Common utilities for rainbow scripts

# All rainbow scripts should set this but by adding it here as well we make sure
set -eu

warning() {
	echo "Warnig:" "$@" >&2
}

fail() {
	echo "$0:" "$@" >&2
	exit 1
}

internal_error() {
	echo "$0: Internal error:" "$@" >&2
	exit 3
}

# This function should be used to load any other source files that are part of
# rainbow except of this one.
srcdir="$(dirname "$(readlink -f "$0")")"
loadsrc() {
	local name="$1"
	if ! echo "${_src_loaded:-}" | grep -qF "+$name+"; then
		. "$srcdir/$name.sh"
		_src_loaded="${_src_loaded:-}+$name+"
	fi
}
