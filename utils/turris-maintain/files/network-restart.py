#!/usr/bin/python3

import uci
import time
import json
import re
import subprocess

from foris_controller.buses.mqtt import MqttNotificationSender

TIME = 2000
STEP = 200


u = uci.Uci()


def uci_get(config, section, option, default):
    try:
        val = u.get(config, section, option)
    except uci.UciExceptionNotFound:
        return default
    return val



controller_id = None

host = uci_get("foris-controller", "mqtt", "host", "localhost")
port = int(uci_get("foris-controller", "mqtt", "port", 11883))
passwd_path = uci_get(
    "foris-controller", "mqtt", "credentials_file", "/etc/fosquitto/credentials.plain"
)
try:
    controller_id = subprocess.check_output(
        ["crypto-wrapper", "serial-number"]).decode().strip()
except subprocess.CalledProcessError:
    controller_id = None
with open(passwd_path, "r") as f:
    credentials = re.match(r"^([^:]+):(.*)$", f.readlines()[0][:-1]).groups()
sender = MqttNotificationSender(host, port, credentials)

ips = []
# try to detect ips from uci
ips += [e for e in uci_get("network", "wan", "ipaddr", "").split(" ") if e]
ips += [e for e in uci_get("network", "wan", "ip6addr", "").split(" ") if e]
ips += [e for e in uci_get("network", "lan", "ipaddr", "").split(" ") if e]
ips += [e for e in uci_get("network", "lan", "ip6addr", "").split(" ") if e]

# try to detect_ips from ubus
for network in ["wan", "lan"]:
    try:
        output = subprocess.check_output(["ifstatus", network])
        data = json.loads(output)
        ips += [e["address"] for e in data.get("ipv4-address", [])]
        ips += [e["address"] for e in data.get("ipv6-address", [])]
    except (subprocess.CalledProcessError, ):
        pass


remains = TIME
while remains > 0:
    sender.notify(
        "maintain", "network-restart", {"ips": list(set(ips)), "remains": remains},
        controller_id=controller_id,
    )
    time.sleep(float(STEP) / 1000)
    remains -= STEP

sender.notify(
    "maintain", "network-restart", {"ips": ips, "remains": 0}, controller_id=controller_id,
)

subprocess.call(["/etc/init.d/network", "reload"])
