#!/bin/sh

PID_FILE="/var/run/suricata.pid"

download_rules() {
    rm -rf /tmp/suricata/rules
    mkdir -p /tmp/suricata/rules
    cd /tmp/suricata/rules
    timeout=60
    while ! ping -c 1 rules.emergingthreats.net > /dev/null 2>&1 && [ $timeout -gt 0 ]; do
        sleep 1
    done
    ping -c 1 rules.emergingthreats.net > /dev/null 2>&1 || exit 1
    curl https://rules.emergingthreats.net/open/suricata/emerging.rules.tar.gz | gzip -cd - | tar -xf -
    mv rules/* .
    rmdir rules
}

reload_suricata() {
    pid="`cat $PID_FILE 2> /dev/null`"
    if [ "$pid" ]; then
        kill -USR2 $pid
    fi
}

if [ "$(uci -q get suricata.rules.download)" -gt 0 ] || [ x"$1" = x-f ]; then
    last_changed="0`cat /tmp/suricata/rules/timestamp 2>/dev/null`"
    current="`date +%s`"
    diff="`expr $current - $last_changed`"
    diff="`expr $diff / 3600`"
    interval="`uci -q get suricata.rules.update_interval`"
    [ "$interval" ] || interval=24
    if [ $diff -gt $interval ] || [ x"$1" = x-f ]; then
        download_rules
        reload_suricata
    fi
fi
