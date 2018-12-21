#!/usr/bin/python3

import uci
import json
import sys

from paho.mqtt import client as mqtt


u = uci.Uci()


def uci_get(config, section, option, default):
    try:
        val = u.get(config, section, option)
    except uci.UciExceptionNotFound:
        return default
    return val

show_advertize = len(sys.argv) > 1 and sys.argv[1] == "-a"
host = uci_get("foris-controller", "mqtt", "host", "localhost")
port = int(uci_get("foris-controller", "mqtt", "port", 11883))


def on_connect(client, userdata, flags, rc):
    print(f"Connected.")
    client.subscribe("foris-controller/#")


def on_subscribe(client, userdata, mid, granted_qos):
    print(f"Subscribed to mid='{mid}'.")


def on_message(client, userdata, msg):
    if msg.topic == "foris-controller/advertize" and not show_advertize:
        return
    title = f"===================== message recieved for '{msg.topic}' ====================="
    print(title)
    try:
        parsed = json.loads(msg.payload)
        print(json.dumps(parsed, indent=2))
    except ValueError:
        print(msg.payload)
    print("=" * len(title))


client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message
client.on_subscribe = on_subscribe

client.connect(host, port, 30)
print(f"Connecting to host {host}:{port}.")
client.loop_forever()
