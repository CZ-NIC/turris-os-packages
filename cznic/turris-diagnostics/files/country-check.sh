#!/bin/sh
set -e

COUNTRY_SYSTEM_VALID='true'
COUNTRY_WIRELESS_VALID='true'

MISSING_COUNTRY_MESSAGE=$(cat <<-EOF
	Your system does not have a country (region) set correctly.
	Please go to the Foris web interface, make sure you have set correct
	country in the "Region and time" tab and then "Save" your wireless
	configuration in the "Wi-Fi" tab again.
EOF
)


main() {
	# check all wireless wi-fi device sections
	. /lib/functions.sh
	config_load wireless
	config_foreach wireless_section_check_country wifi-device

	# check system configuration (there is always only one section)
	check_country_system

	send_notification
}


check_valid_country() {
	local country="$1"
	[ -n "$country" -a "$country" != '00' ]
}


wireless_section_check_country() {
	local section_name="$1"

	local disabled
	config_get_bool disabled "$section_name" disabled 0
	[ "$disabled" = '1' ] && {
		return
	}

	local country
	config_get country "$section_name" country

	if ! check_valid_country "$country"; then
		COUNTRY_WIRELESS_VALID='false'
	fi
}


check_country_system() {
	local country
	country="$(uci get -q 'system.@system[0]._country')" || true

	if ! check_valid_country "$country"; then
		COUNTRY_SYSTEM_VALID='false'
	fi
}


send_notification() {
	if [ "$COUNTRY_WIRELESS_VALID" = 'false' -o "$COUNTRY_SYSTEM_VALID" = 'false' ]; then
		create_notification -s error "$MISSING_COUNTRY_MESSAGE"
	fi
}


main
