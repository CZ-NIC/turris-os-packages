DISABLED="disabled"
FAILED="failed"
RUNNING="running"
SENDING="sending"

echo_res() {
	printf "%s: " "$1"
	case "$2" in
		"$DISABLED") # disabled and not running
			echo "DISABLED"
			;;
		"$FAILED") # enabled but not running
			echo "FAILED"
			;;
		"$RUNNING") # running but not sending any data
			echo "RUNNING"
			;;
		"$SENDING") # correctly sending data
			echo "SENDING"
			;;
		*)
			echo "UNKNOWN"
			;;
	esac
}


service_is_running() {
	local service_name="$1"
	ubus -S call service list "{'name': '$service_name'}" \
		| jsonfilter -e '$.*.instances[@.running=true].pid' >/dev/null
}
