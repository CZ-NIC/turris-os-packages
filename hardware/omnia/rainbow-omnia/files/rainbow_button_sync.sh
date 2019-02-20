#!/bin/sh

MAGIC_FILE="/etc/rainbow.magic"

# Get actual intensity
ACT_INTENSITY=$(rainbow get intensity)

# Get value from magic file
[ -f "$MAGIC_FILE" ] || echo 0 > "$MAGIC_FILE"
LAST_VALUE=$(cat "$MAGIC_FILE")

# Compare them and if last value is different from stored one update it
if [ "$ACT_INTENSITY" != "$LAST_VALUE" ]; then
	echo $ACT_INTENSITY > "$MAGIC_FILE"
fi
