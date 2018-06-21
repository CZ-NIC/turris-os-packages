#!/bin/bash
START_DEBUG_CMD="/etc/resolver/resolver-debug.sh start"
START_DEBUG_DESC="Start resolver debugging"
STOP_DEBUG_CMD="/etc/resolver/resolver-debug.sh stop"
STOP_DEBUG_DESC="Stop resolver debugging"
PRINT_LOG_CMD="/etc/resolver/resolver-debug.sh print-logs"
PRINT_LOG_DESC="Print debug log"

test_log() {
	while read data; do
	logger -t resolver-debug "$data"
	echo "$data"
	done
}

run_kresd_command () {
	KRESD_TTY="$(uci get resolver.kresd.rundir)/tty/$(pidof kresd|awk '{print $1}')"
	echo "${1}" | socat - "unix-connect:${KRESD_TTY}"
}

run_unbound_command () {
	cmd="$1"
	which unbound-control; echo $?
	if [ "$?" -eq 0 ]; then
		unbound-control "$cmd" | test_log
	else
		echo "unbound-control not found" | test_log
	fi
}

add_luci_custom_cmd () {
	cmd="$1"
	description="$2"
	cfg_name=$(uci add luci command)

	uci set luci.$cfg_name.name="$description"
	uci set luci.$cfg_name.command="$cmd"
	uci commit luci
}

remove_luci_custom_cmd () {
	cmd_arg="$1"
	for item in $(uci show luci|grep "@command"|grep ".command=")
	do
		num=$(echo "$item"|awk -F"[" '{print $2}'|awk -F"]" '{print $1}')
		cmd=$(echo "$item"|awk -F"'" '{print $2}')
		if [ "$cmd_arg" = "$cmd" ]; then
			echo "Remove cmd $cmd"
			echo num $num
			uci del luci.@command[$num]
			uci commit luci
		fi
	done
}

run_dig () {
	dig @127.0.0.1 +dnssec "${1}" | test_log
}

run_nslookup () {
	nslookup "${1}" 127.0.0.1 | test_log
}

set_kresd_log() {
	uci set resolver.kresd.log_stderr="$1"
	uci set resolver.kresd.log_stdout="$1"
	uci commit resolver
	/etc/init.d/resolver restart 2>&1 | logger &
}

start_debug () {
	local resolver

	resolver="$(uci get resolver.common.prefered_resolver)"
	if [ "${resolver}" == "kresd" ]; then
		echo "== enable verbose logging (reboot to disable it) ==" |test_log
		set_kresd_log 1
		run_kresd_command "policy.add(policy.all(policy.QTRACE))"
		run_kresd_command "table.insert(policy.rules, 1, table.remove(policy.rules))"
		run_kresd_command "verbose(true)"
	elif [ "${resolver}" == "unbound" ]; then
		echo "== enable verbose logging (reboot to disable it) ==" |test_log
		run_unbound_command "verbosity 5"
	fi

}

stop_debug () {
	local resolver
	resolver="$(uci get resolver.common.prefered_resolver)"

	if [ "${resolver}" == "kresd" ]; then
		echo "== kresd disabled verbose logging ==" |test_log
		set_kresd_log 0
		run_kresd_command "verbose(false)"
	elif [ "${resolver}" == "unbound" ]; then
		echo "== unbound disabled verbose logging ==" |test_log
		run_unbound_command "verbosity 0"
	fi
}

run_test () {
	# dig has richer output format
	which dig &> /dev/null
	if [ "$?" -eq 0 ]; then
		QTOOL="dig"
	else
		QTOOL="nslookup"
	fi

	# resolver config
	uci -q show resolver |test_log
	echo "== resolv.conf* ==" |test_log
	grep -H '' /etc/resolv.conf* /tmp/resolv.conf* |test_log
	echo "== DNSSEC root key file ==" |test_log

	ROOTKEYFILE=$(uci get resolver.common.keyfile)
	#ls -al "${ROOTKEYFILE}"  |test_log
	md5sum "${ROOTKEYFILE}" |test_log
	grep -H '' "${ROOTKEYFILE}" |test_log
	cat ${ROOTKEYFILE} |test_log
	echo "== resolver process ==" |test_log

	RESOLVER="$(uci get resolver.common.prefered_resolver)"
	ps w | grep ${RESOLVER} |test_log


	if [ "${RESOLVER}" == "kresd" ]; then
		echo "== configured trust anchors ==" |test_log
		run_kresd_command "trust_anchors" |test_log
		echo "== enable verbose logging (reboot to disable it) ==" |test_log
		run_kresd_command "verbose(true)"
	elif [ "${RESOLVER}" == "unbound" ]; then
		echo TBD
	fi

	echo "== resolution attempts =="
	run_${QTOOL} api.turris.cz  # should pass
	run_${QTOOL} www.google.com  # should pass
	run_${QTOOL} www.facebook.com  # should pass
	run_${QTOOL} www.youtube.com  # should pass

	run_${QTOOL} www.rhybar.cz  # should fail
	run_${QTOOL} *.wilda.rhybar.0skar.cz  # should fail
	run_${QTOOL} *.wilda.nsec.0skar.cz  # should pass
	run_${QTOOL} *.wild.nsec.0skar.cz  # should pass
	run_${QTOOL} *.wilda.0skar.cz  # should pass
	run_${QTOOL} *.wild.0skar.cz  # should pass
	run_${QTOOL} www.wilda.nsec.0skar.cz  # should pass
	run_${QTOOL} www.wilda.0skar.cz  # should pass
	run_${QTOOL} *.wilda.rhybar.ecdsa.0skar.cz  # should fail
}

print_log() {
	echo "====Log===="
	date
	echo "==========="
	cat /var/log/messages
}


print_help () {
cat << EOF
Help
================

star		- star resolver debug
stop		- stop resolver debug
add-btn		- add buttons to luci custom command
remove-btn	- remove buttons from luci custom command
EOF
}

cmd="$1"
case $cmd in
	start)
		echo "Start debug"
		start_debug
		run_test
		echo "Debug stated" | test_log
	;;
	stop)
		echo "Stop debug"
		stop_debug
		echo "Debug ended" | test_log
	;;
	print-logs)
		echo "Print logs"
		print_log
	;;
	add-btn)
		echo "Add btn to luci custom command"
		add_luci_custom_cmd "$START_DEBUG_CMD" "$START_DEBUG_DESC"
		add_luci_custom_cmd "$STOP_DEBUG_CMD" "$STOP_DEBUG_DESC"
		add_luci_custom_cmd "$PRINT_LOG_CMD" "$PRINT_LOG_DESC"
	;;
	remove-btn)
		echo "Remove btn from luci custom command"
		remove_luci_custom_cmd "$START_DEBUG_CMD"
		remove_luci_custom_cmd "$STOP_DEBUG_CMD"
		remove_luci_custom_cmd "$PRINT_LOG_CMD"
	;;
	help|*)
		print_help
	;;
esac
