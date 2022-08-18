#!/usr/bin/python3

import time
import json
import re
import subprocess
import euci

from foris_controller.buses.mqtt import MqttNotificationSender

TIME = 2000
STEP = 200


uci = euci.EUci()
controller_id = None

host = uci.get("foris-controller", "mqtt", "host", default="localhost")
port = uci.get("foris-controller", "mqtt", "port", dtype=int, default=11883)
passwd_path = uci.get(
    "foris-controller", "mqtt", "credentials_file", default="/etc/fosquitto/credentials.plain"
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
# parse ips as if they were in CIDR notation
ips += [e.split("/")[0] for e in uci.get("network", "lan", "ipaddr", list=True, default=()) if e]
ips += [e.split("/")[0] for e in uci.get("network", "lan", "ip6addr", list=True, default=()) if e]
ips += [e.split("/")[0] for e in uci.get("network", "wan", "ipaddr", list=True, default=()) if e]
ips += [e.split("/")[0] for e in uci.get("network", "wan", "ip6addr", list=True, default=()) if e]

# try to detect_ips from ubus
for network in ["lan", "wan"]:
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
