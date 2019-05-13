#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: cznic
"""

import json
import xml.etree.ElementTree as etree
import subprocess
import syslog
import sys
import select
import os


def call_cmd(cmd):
    assert isinstance(cmd, list)
    task = subprocess.Popen(cmd, shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    data = task.stdout.read()
    return data


class DeckardTests:
    def __init__(self):
        self._resolv_conf_file = "/tmp/resolv.conf.auto"

    def run_tests(self):
        pass
        # run_test_forwarder ...
        #
        # /usr/bin/python3 -m pytest forwarder_check.py --forwarder 127.0.0.1 --junitxml forwarder.xml
        # test_file="/test_deckard/deckard/tools/forwarder_check.py",

    def run_test_forwarder(self, test_file="forwarder_check.py", forwarder_ip="127.0.0.1", test_out="forwarder.xml"):
        cmd = ["/usr/bin/python3", "-m",
             "pytest", test_file,
             "--forwarder", forwarder_ip,
             "--junitxml", test_out]
        out_call = call_cmd(cmd)
        return out_call

    def run_test_network(self, test_file="network_check.py", test_out="network.xml"):
        cmd = ["/usr/bin/python3", "-m",
             "pytest", test_file,
             "--junitxml", test_out]
        out_call = call_cmd(cmd)
        return out_call

    def parse_test(self, xml_file):
        tests_out = []
        tree = etree.parse(xml_file)
        root = tree.getroot()
        for child in root:
            test_name = child.attrib["name"].replace("_", " ").capitalize()
            sysout = child.find("system-out")
            failure = child.find("failure")
            if sysout is not None:
                pass
            #    print(len(sysout.text))

            if failure is not None:
                status_fail = True
            else:
                status_fail = False
            tests_out.append({
                    "name": test_name,
                    "failed": status_fail
                        })
        return {"tests": tests_out, "stats": root.attrib}

    def __get_lan_dns_ip(self):
        return call_cmd(["uci", "get", "network.lan.ipaddr"]).strip().decode("utf-8")

    def __get_isp_dns_ip(self, resolver_file):
        ret = []
        if os.path.isfile(resolver_file):
            with open(resolver_file, "r") as fp:
                for line in fp.readlines():
                    if line.find("nameserver") >= 0:
                        nameserver_ip = line.split(" ")[1].strip()
                        ret.append(nameserver_ip)
        return ret


    def get_dns_list(self):
        ret = []
        lan_dns = self.__get_lan_dns_ip()
        isp_dns = self.__get_isp_dns_ip(self._resolv_conf_file)
        for dns in isp_dns:
            name = "ISP DNS server " + str(isp_dns.index(dns)+1)
            ret.append({"name": name, "ipaddr": dns})
        ret.append({"name": "Router DNS", "ipaddr": lan_dns})
        return ret


# list of availeble methods  via rpcd service
cmd_list = {
        "test_forwarder": {"forwarder": "str"},
        "test_network": {},
        "get_dns_list": {},
        "get_logs": {}
}


def load_stdin_args():
    if select.select([sys.stdin, ], [], [], 0.0)[0]:
        return json.loads(str(sys.stdin.readlines()[0]))
    else:
        return None


if __name__ == "__main__":
    if len(sys.argv) > 1:
        if sys.argv[1] == "list":
            print(json.dumps(cmd_list))
        elif sys.argv[1] == "call":
            dt = DeckardTests()
            args = load_stdin_args()
            syslog.syslog(str(args))
            # parse commands
            if sys.argv[2] == "test_forwarder":
                bb = dt.run_test_forwarder(
                        test_file="/test_deckard/deckard/tools/forwarder_check.py",
                        forwarder_ip=str(args["forwarder"]),
                        test_out="/tmp/forwarder.xml"
                        )
                print(json.dumps({"status": dt.parse_test("/tmp/forwarder.xml")}))
                # print('{"ip_forwarder":"%s"}' % str(args["forwarder"]))
            elif sys.argv[2] == "test_network":
                bb = dt.run_test_forwarder(
                        test_file="/test_deckard/deckard/tools/network_check.py",
                        test_out="/tmp/network.xml"
                        )
                print(json.dumps({"status": dt.parse_test("/tmp/network.xml")}))
                # print('{"ip_server":"%s"}' % str(args["server"]))
            elif sys.argv[2] == "get_dns_list":
                print(json.dumps({"status": dt.get_dns_list()}))
            elif sys.argv[2] == "get_logs":
                print('{"status":"%s"}' % str("test_logs"))
        else:
            dt = DeckardTests()
            syslog.syslog("Unknown argument.")


"""
Example calls:
ubus -v call xml_parser.py "test_forwarder" '{"forwarder":"1.1.1.1"}'
{
        "ip_forwarder": "1.1.1.1"
}

ubus -v call xml_parser.py "test_network" '{"server":"1.1.1.1"}'
{
        "ip_server": "1.1.1.1"
}



"""
