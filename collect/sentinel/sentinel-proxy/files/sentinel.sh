#!/bin/sh

# source OpenWrt functions if not sourced yet
command -v config_load > /dev/null || . /lib/functions.sh


allowed_to_run() {
	local component_name="$1";
	agreed_with_eula "${component_name}" && component_enabled "${component_name}"
}

component_enabled() (
	local component_name="$1";
	config_load sentinel

	local enabled
	config_get_bool enabled "${component_name}" enabled "1"
	[ "$enabled" = "1" ] || {
		echo "Sentinel ${component_name} not enabled" >&2
		return 1
	}
)

agreed_with_eula() (
	local component_name="$1";
	config_load sentinel

	local agreed_eula_version
	config_get agreed_eula_version main agreed_with_eula_version "0"
	[ "$agreed_eula_version" -le "0" ] || return 0

	cat >&2 <<EOF
Not agreed with EULA.

EULA could be found at /usr/share/sentinel-eula/ and you can
agree with it either in ReForis data collect tab or using
uci config:
uci set sentinel.main.agreed_with_eula_version=1 && uci commit

EULA version may increase in time. See documentation for more details.
EOF
	return 1
)
