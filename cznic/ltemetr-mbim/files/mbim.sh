#!/bin/sh

[ -n "$INCLUDE_ONLY" ] || {
	. /lib/functions.sh
	. ../netifd-proto.sh
	init_proto "$@"
}
#DBG=-v

proto_mbim_init_config() {
	available=1
	no_device=1
	proto_config_add_string "device:device"
	proto_config_add_string apn
	proto_config_add_string pincode
	proto_config_add_string delay
	proto_config_add_string auth
	proto_config_add_string username
	proto_config_add_string password
}

parse_config ()
{
    IP=$(cat /tmp/ip |grep ipv4address |grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/([0-9]|[1-2][0-9]|3[0-2])")
    GW=$(cat /tmp/ip |grep ipv4gateway |grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)")
    DNS=$(cat /tmp/ip |grep ipv4dnsserver |grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" |head -1)
}

_proto_mbim_setup() {
	local interface="$1"
	local tid=2
	local ret

	local device apn pincode delay
	json_get_vars device apn pincode delay auth username password

	[ -n "$ctl_device" ] && device=$ctl_device

	[ -n "$device" ] || {
		echo "mbim[$$]" "No control device specified"
		proto_notify_error "$interface" NO_DEVICE
		proto_set_available "$interface" 0
		return 1
	}
	[ -c "$device" ] || {
		echo "mbim[$$]" "The specified control device does not exist"
		proto_notify_error "$interface" NO_DEVICE
		proto_set_available "$interface" 0
		return 1
	}

	devname="$(basename "$device")"
	devpath="$(readlink -f /sys/class/usbmisc/$devname/device/)"
	ifname="$( ls "$devpath"/net )"

	[ -n "$ifname" ] || {
		echo "mbim[$$]" "Failed to find matching interface"
		proto_notify_error "$interface" NO_IFNAME
		proto_set_available "$interface" 0
		return 1
	}

	[ -n "$apn" ] || {
		echo "mbim[$$]" "No APN specified"
		proto_notify_error "$interface" NO_APN
		return 1
	}

	[ -n "$delay" ] && sleep "$delay"

	echo "mbim[$$]" "Reading capabilities"
	umbim $DBG -n -d $device caps || {
		echo "mbim[$$]" "Failed to read modem caps"
		proto_notify_error "$interface" PIN_FAILED
		return 1
	}
	tid=$((tid + 1))

	echo "mbim[$$]" "Checking subscriber"
 	umbim $DBG -n -t $tid -d $device subscriber || {
		echo "mbim[$$]" "Subscriber init failed"
		proto_notify_error "$interface" NO_SUBSCRIBER
		return 1
	}
	tid=$((tid + 1))

	echo "mbim[$$]" "Register with network"
  	umbim $DBG -n -t $tid -d $device registration || {
		echo "mbim[$$]" "Subscriber registration failed"
		proto_notify_error "$interface" NO_REGISTRATION
		return 1
	}
	tid=$((tid + 1))

	echo "mbim[$$]" "Attach to network"
   	umbim $DBG -n -t $tid -d $device attach || {
		echo "mbim[$$]" "Failed to attach to network"
		proto_notify_error "$interface" ATTACH_FAILED
		return 1
	}
	tid=$((tid + 1))
 
	echo "mbim[$$]" "Connect to network"
	while ! umbim $DBG -n -t $tid -d $device connect "$apn" "$auth" "$username" "$password"; do
		tid=$((tid + 1))
		sleep 1;
	done
	tid=$((tid + 1))

	uci_set_state network $interface tid "$tid"
	echo "mbim[$$]" "Get IP config"
	CONFIG=$(umbim $DBG -n -t $tid -d $device config) || {
		echo "mbim[$$]" "config failed"
		return 1
	}
	tid=$((tid + 1))

	echo "$CONFIG" > /tmp/ip
	parse_config

	echo "mbim[$$]" "Connected, setting IP"
	proto_init_update "$ifname" 1
	proto_send_update "$interface"

	ip address add $IP dev wwan0
	ip route add default dev wwan0

	echo "nameserver $DNS" >> /tmp/resolv.conf.auto
	echo "nameserver $DNS" >> /etc/resolv.conf

	return 0
}

proto_mbim_setup() {
	local ret

	_proto_mbim_setup $@
	ret=$?

	[ "$ret" = 0 ] || {
		logger "mbim bringup failed, retry in 15s"
		sleep 15
	}

	return $rt
}

proto_mbim_teardown() {
	local interface="$1"

	local device
	json_get_vars device
	local tid=$(uci_get_state network $interface tid)

	[ -n "$ctl_device" ] && device=$ctl_device

	echo "mbim[$$]" "Stopping network"
	[ -n "$tid" ] && {
		umbim $DBG -t$tid -d "$device" disconnect
		uci_revert_state network $interface tid
	}

	proto_init_update "*" 0
#	proto_send_update "$interface"
}

[ -n "$INCLUDE_ONLY" ] || add_protocol mbim
