#!/bin/sh
STATUS_DIR="/usr/libexec/sentinel/status.d/"

for status_script in "${STATUS_DIR}"/*; do
	[ -x "${status_script}" ] || continue
	"${status_script}"
done
