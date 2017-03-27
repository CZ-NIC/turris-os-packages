#!/bin/sh

CONF="/etc/freeradius2"
INIT="/etc/init.d/radiusd"

. /lib/functions.sh
config_load radius

rebuild()
{
	clear_configure
	config_foreach append_client client
	config_foreach append_user user
	reload_radiusd
}

clear_configure()
{
	echo > $CONF/clients.conf
	echo > $CONF/users
}

append_client()
{
	local name ipaddr secret
	config_get name $1 name
	config_get ipaddr $1 ipaddr
	config_get secret $1 secret

	cat <<-EOF >>$CONF/clients.conf
client $ipaddr {
	secret = $secret
	shortname = $name
}
EOF
}

append_user()
{
	local username password
	config_get username $1 username
	config_get password $1 password

	cat <<-EOF >>$CONF/users
$username Cleartext-Password := "$password"
EOF
}

reload_radiusd()
{
	"$INIT" restart
}

case "$1" in
  rebuild)
    rebuild
  ;;
esac
exit 0
