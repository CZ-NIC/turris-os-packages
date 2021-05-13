#!/bin/sh

if [ -f /srv/www/nextcloud/config/config.php ]; then
	/usr/bin/php-cli -f /srv/www/nextcloud/cron.php
fi
