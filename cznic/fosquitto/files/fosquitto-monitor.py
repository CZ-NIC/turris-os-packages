#!/usr/bin/python3

import argparse
import json
import re
import time
import uci
import uuid

import typing

from paho.mqtt import client as mqtt

u = uci.Uci()


def uci_get(config: str, section: str, option: str, default):
    try:
        val = u.get(config, section, option)
    except uci.UciExceptionNotFound:
        return default
    return val


def read_passwd_file(path: str) -> typing.Tuple[str]:
    """ Returns username and password from passwd file
    """
    with open(path, "r") as f:
        return re.match(r"^([^:]+):(.*)$", f.readlines()[0][:-1]).groups()


def parse_cmdline():
    parser = argparse.ArgumentParser(prog="fosquitto-monitor")
    parser.add_argument("-H", "--host", default=None, required=False)
    parser.add_argument("-P", "--port", type=int, default=0, required=False)
    parser.add_argument(
        "-F",
        "--passwd-file",
        type=lambda x: read_passwd_file(x),
        help="path to passwd file (first record will be used to authenticate)",
        default="/etc/fosquitto/credentials.plain",
    )

    commands = parser.add_subparsers(help="command which will be performend", dest="command")
    commands.required = True

    listen_parser = commands.add_parser("listen", help="listen for messages on the bus")

    listen_parser.add_argument(
        "-a",
        "--show-advertize",
        action="store_true",
        default=False,
        help="display advertize messages",
    )
    listen_parser.add_argument(
        "-f",
        "--filter-ids",
        default=[],
        dest="filter_ids",
        nargs="+",
        help="display only messages containing specified ids",
        required=False,
    )

    detect_parser = commands.add_parser("detect", help="detects ids of connected devices")
    detect_parser.add_argument("-t", "--timeout", type=float, default=0.0, required=False)

    list_parser = commands.add_parser("list", help="print list of modules and actions")
    list_parser.add_argument(
        "-i", "--device-id", required=True, help="device id - obtained via detect cmd"
    )
    list_parser.add_argument(
        "-m",
        "--filter-modules",
        default=[],
        dest="filter_modules",
        nargs="+",
        help="display only data regarding specific modules",
        required=False,
    )

    schemas_parser = commands.add_parser("schemas", help="prints current json schemas")
    schemas_parser.add_argument(
        "-i", "--device-id", required=True, help="device id - obtained via detect cmd"
    )

    return parser.parse_args()


def listener(
    host: str,
    port: int,
    show_advertize: bool,
    filter_ids: typing.Set[str],
    credentials: typing.Tuple[str],
):
    def on_connect(client, userdata, flags, rc):
        print(f"Connected.")
        client.subscribe("foris-controller/#")

    def on_subscribe(client, userdata, mid, granted_qos):
        print(f"Subscribed to mid='{mid}'.")

    def on_message(client, userdata, msg):
        if (
            re.match(f"foris-controller/[^/]+/notification/remote/action/advertize", msg.topic)
            and not show_advertize
        ):
            return
        try:
            # filter id
            if filter_ids:
                match = re.match(r"^foris-controller/([^/]+).*", msg.topic)
                if match.group(1) not in filter_ids:
                    return

            title = (
                f"===================== message recieved for '{msg.topic}' ====================="
            )
            parsed = json.loads(msg.payload)
            content = json.dumps(parsed, indent=2)
        except ValueError:
            content = msg.payload

        print(title)
        print(content)
        print("=" * len(title))

    client = mqtt.Client()
    client.on_connect = on_connect
    client.on_message = on_message
    client.on_subscribe = on_subscribe

    client.username_pw_set(*credentials)
    client.connect(host, port, 30)
    print(f"Connecting to host {host}:{port}.")
    client.loop_forever()


def detect_ids(host: str, port: int, timeout: int, credentials: typing.Tuple[str]):
    ids: typing.Set[str] = set()

    def on_message(client, userdata, msg):
        parsed = json.loads(msg.payload)
        if parsed["data"]["state"] and parsed["data"]["id"] not in ids:
            ids.add(parsed["data"]["id"])
            print(f"{parsed['data']['id']}")

    def on_connect(client, userdata, flags, rc):
        client.subscribe(f"foris-controller/+/notification/remote/action/advertize")

    client = mqtt.Client()
    client.on_connect = on_connect
    client.on_message = on_message

    client.username_pw_set(*credentials)
    client.connect(host, port, 30)
    if timeout:
        start = time.time()
        while time.time() - start < timeout:
            client.loop()
    else:
        client.loop_forever()


def query_bus(host: str, port: int, topic: str, device_id: str, credentials: typing.Tuple[str]):
    result = {"data": None}

    msg_id = uuid.uuid1()
    reply_topic = "foris-controller/%s/reply/%s" % (device_id, msg_id)

    def on_connect(client, userdata, flags, rc):
        client.subscribe(reply_topic)

    def on_subscribe(client, userdata, mid, granted_qos):
        client.publish(topic, json.dumps({"reply_msg_id": str(msg_id)}))

    def on_message(client, userdata, msg):
        try:
            parsed = json.loads(msg.payload)
        except Exception:
            return
        result["data"] = parsed
        client.loop_stop(True)
        client.disconnect()

    client = mqtt.Client()
    client.on_subscribe = on_subscribe
    client.on_message = on_message
    client.on_connect = on_connect
    client.username_pw_set(*credentials)
    client.connect(host, port, 30)
    client.loop_start()
    client._thread.join(5)

    if result["data"] is None:
        raise Exception("No answer recieved.")

    return result["data"]


def list_objects(
    host: str, port: int, device_id: str, modules: typing.List[str], credentials: typing.Tuple[str]
):
    if not modules:
        topic = f"foris-controller/{device_id}/list"
        for module in query_bus(host, port, topic, device_id, credentials):
            for action in module["actions"]:
                print(f"{module['name']}.{action}")
            print()
    else:
        for module in modules:
            topic = f"foris-controller/{device_id}/request/{module}/list"
            for action in query_bus(host, port, topic, device_id, credentials):
                print(f"{module}.{action}")
            print()


def display_schemas(host: str, port: int, device_id: str, credentials: typing.Tuple[str]):
    topic = f"foris-controller/{device_id}/jsonschemas"
    print(json.dumps(query_bus(host, port, topic, device_id, credentials), indent=2))


def main():
    options = parse_cmdline()
    host = options.host or uci_get("foris-controller", "mqtt", "host", "localhost")
    port = options.port or int(uci_get("foris-controller", "mqtt", "port", 11883))

    if options.command == "listen":
        listener(host, port, options.show_advertize, options.filter_ids, options.passwd_file)
    elif options.command == "detect":
        detect_ids(host, port, options.timeout, options.passwd_file)
    elif options.command == "list":
        list_objects(host, port, options.device_id, options.filter_modules, options.passwd_file)
    elif options.command == "schemas":
        display_schemas(host, port, options.device_id, options.passwd_file)


if __name__ == "__main__":
    main()
