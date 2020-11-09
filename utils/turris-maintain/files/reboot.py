#!/usr/bin/python3

import time
import json
import re
import subprocess
import euci

TIME = 3000
STEP = 200


with euci.EUci() as uci:
    bus = uci.get("foris-controller", "main", "bus", default="ubus")

    controller_id = None

    if bus == "ubus":
        path = uci.get(
            "foris-controller", "ubus", "notification_path",
            default="/var/run/ubus.sock"
        )
        from foris_controller.buses.ubus import UbusNotificationSender
        sender = UbusNotificationSender(path)
    elif bus == "unix":
        path = uci.get(
            "foris-controller", "unix", "notification_path",
            default="/var/run/foris-controller-notifications.sock"
        )
        from foris_controller.buses.unix_socket import UnixSocketNotificationSender
        sender = UnixSocketNotificationSender(path)
    elif bus == "mqtt":
        host = uci.get("foris-controller", "mqtt", "host", default="localhost")
        port = int(uci.get("foris-controller", "mqtt", "port", default=11883))
        passwd_path = uci.get(
            "foris-controller", "mqtt", "credentials_file", default="/etc/fosquitto/credentials.plain"
        )
        with open(passwd_path, "r") as f:
            credentials = re.match(r"^([^:]+):(.*)$", f.readlines()[0][:-1]).groups()
        try:
            controller_id = subprocess.check_output(
                ["crypto-wrapper", "serial-number"]).decode().strip()
        except subprocess.CalledProcessError:
            controller_id = None
        from foris_controller.buses.mqtt import MqttNotificationSender
        sender = MqttNotificationSender(host, port, credentials)

    ips = []
    # try to detect ips from uci
    ips += [e for e in uci.get("network", "wan", "ipaddr", list=True, default=()) if e]
    ips += [e for e in uci.get("network", "wan", "ip6addr", list=True, default=()) if e]
    ips += [e for e in uci.get("network", "lan", "ipaddr", list=True, default=()) if e]
    ips += [e for e in uci.get("network", "lan", "ip6addr", list=True, default=()) if e]

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
        "maintain", "reboot", {"ips": list(set(ips)), "remains": remains},
        controller_id=controller_id,
    )
    time.sleep(float(STEP) / 1000)
    remains -= STEP

sender.notify(
    "maintain", "reboot", {"ips": ips, "remains": 0}, controller_id=controller_id,
)

subprocess.call("reboot")
