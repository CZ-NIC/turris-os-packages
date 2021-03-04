#!/bin/sh
# restart Sentinel:FWLogs service
/etc/init.d/sentinel-fwlogs restart
# Apply logging rules
/etc/init.d/firewall reload
