#!/bin/sh
# This script disables trusted domain check for nextcloud
# by pushing * to trusted domain list

NEXTCLOUD_CLI_SCRIPT="/srv/www/nextcloud/occ"

nextcloud_cli() {
	sudo -u nobody php-cli "$NEXTCLOUD_CLI_SCRIPT" "$@"
}

if [ ! -f "$NEXTCLOUD_CLI_SCRIPT" ]; then
	echo "Error: occ command not found!" >&2
	exit 1
fi

# check if * is in config.php
ret_val=$(
	nextcloud_cli config:system:get trusted_domains \
		| awk '$1 == "*" { print "isDisabled"; exit }'
)

# Check for reset script argument
if [ "$1" = "reset" ]; then
	nextcloud_cli config:system:delete trusted_domains 1000
	echo "Info: Trusted domains enabled." >&2
	exit
fi

if [ "$ret_val" = "isDisabled" ]; then
	echo "Info: Trusted domains already disabled. Nothing to do." >&2
else
	echo "Info: Disabling trusted domains." >&2
	nextcloud_cli config:system:set trusted_domains 1000 --value='*'
fi
