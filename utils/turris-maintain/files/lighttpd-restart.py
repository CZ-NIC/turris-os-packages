#!/usr/bin/python3

import time
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
