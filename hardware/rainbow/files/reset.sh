reset_usage() {
	echo "Usage: $0 reset [OPTION].." >&2
}
reset_help() {
	reset_usage
	cat >&2 <<-EOF
		Reset current runtime configuration.

		Options:
		  -n  Do not remove current configuration only apply it
		  -a  Reset all priority levels and slots not just the current one
		  -b  Run boot sequence as part of reset
		  -h  Print this help text and exit
	EOF
}

op_reset() {
	local nowipe="n"
	local all="n"
	local bootseq="n"
	while getopts "nabh" opt; do
		case "$opt" in
			n)
				nowipe="y"
				;;
			a)
				all="y"
				;;
			b)
				bootseq="y"
				;;
			h)
				reset_help
				exit 0
				;;
			*)
				reset_usage
				exit 2
				;;
		esac
	done
	SHIFTARGS=$((OPTIND - 1))

	if [ "$nowipe" = "n" ]; then
		if [ "$all" = "y" ]; then
			rm -f "$rainbowdir"/*
		else
			rm -f "$rainbowdir/$(printf "%03d" "$priority")-$slot"
		fi
	fi

	# Note: the boot sequence is silently ignored if there is none defined
	[ "$bootseq" = "y" ] \
		&& type boot_sequence >/dev/null \
		&& boot_sequence

	apply_needed="y"
}
