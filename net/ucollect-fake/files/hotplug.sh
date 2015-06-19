#!/bin/sh

MD5=$(ip addr | sed -ne 's/.*inet6\? //p' | sed -e 's/\/.*//' | sort -u | md5sum| cut -f1 -d\ )
PREVIOUS=$(cat /tmp/addresses-ucollect-fake.md5 || true)
if [ "$MD5" != "$PREVIOUS" ] ; then
	/etc/firewall.d/with_reload/99-ucollect-fake.fw
	echo "$MD5" >/tmp/addresses-ucollect-fake.md5
fi
