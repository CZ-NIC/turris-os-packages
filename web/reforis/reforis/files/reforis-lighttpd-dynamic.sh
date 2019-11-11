#!/bin/sh

. /lib/functions.sh

config_load reforis
config_get SCRIPTNAME server scriptname "/reforis"
# config_get_bool DEBUG server debug "0"
# config_get_bool NOAUTH auth noauth "0"
config_get SESSION_TIMEOUT auth session_timeout ""
config_get SERVER server server "flup"
config_get SENTRY_DSN sentry dsn ""

# scriptname must not contain escape codes (avoid CRLF injection in sed later)
# and for the sake of UX, trailing and leading slashes are trimmed
SCRIPTNAME=$(echo "$SCRIPTNAME" | sed -e 's;\\;\\\\;g' | sed -e 's;/*$;;g' | sed -e 's;^/*;;g' | sed -e 's;/+;/;g')
[ "$SCRIPTNAME" != "" ] && SCRIPTNAME="/$SCRIPTNAME"

# get bus config
config_load foris-controller
config_get BUS main bus "mqtt"
case "$BUS" in
	ubus)
		config_get BUS_PATH ubus path "/var/run/ubus.sock"
		;;
	mqtt)
		config_get BUS_HOST mqtt host "localhost"
		config_get BUS_PORT mqtt port "11883"
		config_get CREDENTIALS_FILE mqtt credentials_file "/etc/fosquitto/credentials.plain"
		CONTROLLER_ID=$(crypto-wrapper serial-number)
		BUS="mqtt"
		;;
esac

echo "var.reforis.bin = \"/usr/bin/reforis\""
echo "var.reforis.scriptname = \"/reforis\""

echo
echo "\$HTTP[\"url\"] =~ \"^\" + var.reforis.scriptname + \"/(.*)$\" {"
case $SERVER in
	flup)
		echo '	fastcgi.debug = 0'
		echo '	fastcgi.server = ('
		echo "		var.reforis.scriptname => ("
		echo '			"python-fcgi" => ('
		echo "				\"socket\" => \"/tmp/fastcgi.reforis.socket\","
		echo "				\"bin-path\" => var.reforis.bin,"
		echo '				"check-local" => "disable",'
		echo '				"max-procs" => 1,'
		echo '				"bin-environment" => ('
if [ -n "$SENTRY_DSN" ]; then
		echo "					\"SENTRY_DSN\" => \"$SENTRY_DSN\","
fi
		echo "					\"CONTROLLER_ID\" => \"$CONTROLLER_ID\","
		echo '				),'
		echo '			)'
		echo '		)'
		echo '	)'
	;;
	cgi)
		echo "	alias.url = ( var.reforis.scriptname => var.reforis.cgi )"
		echo '	cgi.assign = ( "" => "" )'
	;;
esac
echo "}"


echo "alias.url += ( var.reforis.scriptname + \"/static/\" => \"/usr/lib/python3.6/site-packages/reforis_static/\" )"
