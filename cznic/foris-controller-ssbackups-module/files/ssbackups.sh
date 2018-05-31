#!/bin/sh


error() {
	/usr/bin/create_notification -s error '_(Creating an automatic Cloud Backup from your router failed.)'
	exit 1
}

result=$(/usr/bin/foris-client -m ssbackups -a create_and_upload ubus)
[ $? -ne 0 ] && error
echo "$result" | grep -q '"result": *"passed"' || error
