#!/bin/sh


allowed_to_run() {
    local component_name="$1";
    agreed_with_eula && component_enabled "${component_name}" && return 0
    return 1
}

component_enabled() (
    local component_name="$1";
    config_load sentinel

    local enabled
    config_get_bool enabled "${component_name}" enabled "0"
    [ "$enabled" = "1" ] || {
        echo "Failed to start - ${component_name} not enabled" >&2
        return 1
    }
    return 0
)

agreed_with_eula() (
    config_load sentinel

    local agreed_eula_version
    config_get agreed_eula_version main agreed_with_eula_version "0"
    [ "$agreed_eula_version" -le "0" ] && {
        echo "Failed to start - not agreed with EULA" >&2
        return 1
    }
    return 0
)
