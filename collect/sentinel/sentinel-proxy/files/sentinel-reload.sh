#!/bin/sh
# Reload all sentinel components to apply the newest configuration.
# The reload is done by running scripts located in HOOKS_DIR

HOOKS_DIR="/usr/libexec/sentinel/reload_hooks.d/"

if ! [ -d "${HOOKS_DIR}" ]; then
    echo "Failed to reload Sentinel: hooks dir does not exist" >&2
    return 1
fi

for reload_script in "${HOOKS_DIR}"/*; do
    [ -x "${reload_script}" ] || continue
    "${reload_script}"
done
