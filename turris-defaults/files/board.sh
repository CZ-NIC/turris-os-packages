. /lib/functions/uci-defaults.sh

board_config_update


ucidef_set_hostname 'turris'

while read -r ntpserver; do
	[ -n "$ntpserver" ] || continue
	ucidef_set_ntpserver "$ntpserver"
done < /usr/share/turris-defaults/ntpservers


board_config_flush
