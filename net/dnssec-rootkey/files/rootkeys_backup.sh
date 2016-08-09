#!/bin/sh
#make backup only if rootkey isn't empty

DEFAULT_FILE=/etc/root.keys
UCI_FILE=$(uci get resolver.common.keyfile)

check_root_key() {
	#check if it looks good
	local rootkey_file=$1
	if [ -e $rootkey_file ]; then
		grep -qE '[[:space:]](DNSKEY|DS|TYPE[[:digit:]][[:digit:]])[[:space:]]' $rootkey_file && return 0
	fi
	return 1
}

check_root_key $DEFAULT_FILE && cert-backup $DEFAULT_FILE
[ "$DEFAULT_FILE" == "$UCI_FILE" ] && exit
check_root_key $UCI_FILE && cert-backup $UCI_FILE
