#!/bin/sh

# Get actual intensity
ACT_INTENSITY=$(rainbow get intensity)

# Get value from uci config
LAST_VALUE=$(cat /etc/rainbow.magic)

# Compare them and if last value is different from stored one update it
if [ "$ACT_INTENSITY" != "$LAST_VALUE" ]; then
	echo $ACT_INTENSITY > /etc/rainbow.magic
fi
