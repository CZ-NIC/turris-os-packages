#!/bin/sh

PID_FILE="/var/run/suricata.pid"

download_rules() {
    rm -rf /tmp/suricata/rules
    mkdir -p /tmp/suricata/rules
    cd /tmp/suricata/rules
    curl https://rules.emergingthreats.net/open/suricata/emerging.rules.tar.gz | gzip -cd - | tar -xvf -
    mv rules/* .
    rmdir rules
    echo '%YAML 1.1' > suricata-include.yaml
    echo '---' >> suricata-include.yaml
    echo 'default-rule-path: /tmp/suricata/rules' >> suricata-include.yaml
    sed -n '/rule-files:/,/classification-file:/ p' suricata-1.3-open.yaml | head -n -1 >> suricata-include.yaml
    echo '' >> suricata-include.yaml
    date +%s > timestamp
}

reload_suricata() {
    pid="`cat $PID_FILE 2> /dev/null`"
    if [ "$pid" ]; then
        kill -USR2 $pid
    fi
}

RUNNING="`cat $PID_FILE 2> /dev/null`"
if [ x"$1" = x-f ]; then
    RUNNING=yes
fi

if [ "$(uci -q get suricata.rules.download)" -gt 0 ] && [ "$RUNNING" ]; then
    last_changed="0`cat /tmp/suricata/rules/timestamp 2>/dev/null`"
    current="`date +%s`"
    diff="`expr $current - $last_changed`"
    diff="`expr $diff / 3600`"
    interval="`uci -q get suricata.rules.update_interval`"
    [ "$interval" ] || interval=24
    if [ $diff -gt $interval ]; then
        download_rules
        reload_suricata
    fi
fi
