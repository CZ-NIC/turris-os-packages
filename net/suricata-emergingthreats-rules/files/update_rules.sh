#!/bin/sh

RULES_URL="https://rules.emergingthreats.net/open/suricata-4.0/emerging.rules.tar.gz"
RULES_MD5_URL="https://rules.emergingthreats.net/open/suricata-4.0/emerging.rules.tar.gz.md5"

PID_FILE="/var/run/suricata.pid"
RULES_MD5_FILE="/tmp/suricata/rules.md5"

download_rules() {
    mkdir -p "/tmp/suricata"
    cd /tmp/suricata/
    curl -s $RULES_URL | gzip -cd - | tar -xf - rules
    curl -s $RULES_MD5_URL > $RULES_MD5_FILE
}

reload_suricata() {
    pid="`cat $PID_FILE 2> /dev/null`"
    if [ "$pid" ]; then
        kill -USR2 $pid
    fi
}

if [ ! -f "$RULES_MD5_FILE" ] || [ "$(cat $RULES_MD5_FILE)" != "$(curl -s $RULES_MD5_URL)" ]; then
    sleep 20
    download_rules
    reload_suricata
fi
