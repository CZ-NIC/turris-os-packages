#!/usr/bin/python3

import uci
import time
import re
import subprocess

TIME = 2000
STEP = 200


u = uci.Uci()


def uci_get(config, section, option, default):
    try:
        val = u.get(config, section, option)
    except uci.UciExceptionNotFound:
        return default
    return val


bus = uci_get("foris-controller", "main", "bus", "ubus")

controller_id = None

if bus == "ubus":
    path = uci_get("foris-controller", "ubus", "notification_path", "/var/run/ubus.sock")
    from foris_controller.buses.ubus import UbusNotificationSender
    sender = UbusNotificationSender(path)
elif bus == "unix":
    path = uci_get(
        "foris-controller", "unix", "notification_path",
        "/var/run/foris-controller-notifications.sock"
    )
    from foris_controller.buses.unix_socket import UnixSocketNotificationSender
    sender = UnixSocketNotificationSender(path)
elif bus == "mqtt":
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
    from foris_controller.buses.mqtt import MqttNotificationSender
    sender = MqttNotificationSender(host, port, credentials)


remains = TIME
while remains > 0:
    sender.notify(
        "maintain", "lighttpd-restart", {"remains": remains},
        controller_id=controller_id,
    )
    time.sleep(float(STEP) / 1000)
    remains -= STEP

sender.notify(
    "maintain", "lighttpd-restart", {"remains": 0}, controller_id=controller_id,
)

subprocess.call(["/etc/init.d/lighttpd", "restart"])
