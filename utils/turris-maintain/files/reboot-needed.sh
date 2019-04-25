#!/bin/sh

# mark that a reboot is required for the router

# existence of this file will be verified from other program
touch /tmp/device-reboot-required

if [ -x /usr/bin/foris-notify-wrapper ]; then
	/usr/bin/foris-notify-wrapper -m maintain -a reboot_required "{}"
fi
