#!/usr/bin/python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 24 14:52:08 2018

@author: cz_nic

This script is used for rpcd ubus service.
It should be located in /usr/libexec/rpcd

Example:
    ubus call resolver_rpcd.py list_dns '{}'
    ubus call resolver_rpcd.py active_mode '{}'
    ubus call resolver_rpcd.py forward_upstream_ip '{}'
    ubus call resolver_rpcd.py forward_custom_ip '{}'

    ubus -v list resolver_rpcd.py
    'resolver_rpcd.py' @ae34cecc
        "list_dns":{}
        "active_mode":{}
        "config":{}
        "forward_upstream_ip":{}
        "forward_custom_ip":{}


    ubus call resolver_rpcd.py forward_upstream_ip '{}'
    {
        "forward_upstream_ip": {
            "ipv4": [
                "10.0.1.1"
            ],
            "ipv6": []
        }
    }


python example for ubus call:

import ubus
ubus.connect("/var/run/ubus.sock")

print(ubus.call("resolver_rpcd.py", "list_dns", {}))

"""
import os
from os import listdir
from os.path import isfile, join
import json
import sys
import syslog
from uci import Uci
import socket
import argparse


DNS_SERVERS_DIR = "/etc/resolver/dns_servers/"

FORWARD_CUSTOM = "forward_custom"
FORWARD_UPSTREAM = "forward_upstream"
RECURSIVE = "recursive"


def log():
    pass


def uci_conv_bool(str1, default):
    """Return converted uci bool string to boolean or default."""
    if str1 in ("1", "on", "true", "yes", "enabled"):
        return True
    elif str1 in ("0", "off", "false", "no", "disabled"):
        return False
    else:
        return default


class JsonUbusDecorator:
    """
    Class used by json_ubus decorator.

    Prints return value of function in json format.
    """

    def __init__(self):
        """Init decorator use registry."""
        self.registry = []

    def __call__(self, m):
        """Convert function return value to json."""
        self.registry.append(m.__name__.lstrip("get_"))

        def w(*func_args, **func_kwargs):
            name = m.__name__.lstrip("get_")
            ret = m(*func_args, **func_kwargs)
            print(json.dumps({name: ret}))
            return ret

        return w


json_ubus = JsonUbusDecorator()


class ResolverDoT:
    """
    Class for parsing DoT configuration for Turris resolvers.

    Args:
       path: full path with config file directory
    """

    def __init__(self, path="/etc/resolver/dns_servers/"):
        """Load custom DNS server configs from given directory."""
        self.DNS_list = self.__get_file_configs(path)

    def __get_config(self, filename):
        ret = {}
        with open(filename) as fp:
            for item in fp.readlines():
                line = item.split("#")[0]  # remove comments
                arr = line.split("=", 1)
                if len(arr) == 2:
                    # remove quotation marks
                    name = arr[0].strip(" '\"\n'")
                    vals = arr[1].strip(" '\"\n'")
                    # return IP as list
                    if name == "ipv4" or name == "ipv6":
                        vals = vals.split()
                    ret.update({name: vals})
            if not ("name" in ret):
                return {}
        return ret

    def get_dns_list(self):
        """Return list with available custom DNS servers."""
        return self.DNS_list

    def get_dns(self, name):
        """Return dict wih custom DNS server config values.

        Args:
           name: name of config
        Returns:
           dict with config values or None
        """
        for item in self.DNS_list:
            item_name = item.get("name", None)
            if item_name == name:
                return item
        return None

    def __get_file_configs(self, path, extension="conf"):
        ret_arr = []
        configs_path = self.__get_file_list(path, extension).get("full_path")
        for path in configs_path:
            ret_arr.append(self.__get_config(path))
        return ret_arr

    def __get_file_list(self, mypath, extension="sh"):
        if os.path.isdir(mypath):
            tmp_files = [
                f
                for f in listdir(mypath)
                if isfile(join(mypath, f)) and f.endswith("." + extension)
            ]
            tmp_full = [os.path.join(mypath, f) for f in tmp_files]
            return {"files": tmp_files, "full_path": tmp_full}
        else:
            return {"files": [], "full_path": []}


class ResolverConf:
    """Class for handling /etc/config/resolver uci configuration."""

    def __init__(self):
        """Init config and set resolv.conf.auto location.

        Raises FileExistsError if resolv.conf.auto wasn't found.
        """
        self.__config = self.get_config()

        # test locatin of resolv.conf.auto file
        if os.path.isfile("/tmp/resolv.conf.auto"):
            self.__resolv_path = "/tmp/resolv.conf.auto"
        elif os.path.isfile("/tmp/resolv.conf.d/resolv.conf.auto"):
            self.__resolv_path = "/tmp/resolv.conf.d/resolv.conf.auto"
        else:
            raise FileExistsError(
                "Could not find /tmp/resolv.conf.d/resolv.conf.auto or /tmp/resolv.conf.auto "
            )

    def get_config(self):
        """Return dict with resolver config values."""
        u = Uci()
        resolver_common = u.get("resolver")["common"]
        pref_resolver = resolver_common.get("prefered_resolver", None)

        ignore_root_key = uci_conv_bool(
            resolver_common.get("ignore_root_key", None), None
        )
        forward_upstream = uci_conv_bool(
            resolver_common.get("forward_upstream", None), None
        )
        forward_custom = resolver_common.get("forward_custom", None)
        return {
            "forward_custom": forward_custom,
            "forward_upstream": forward_upstream,
            "dnssec_disabled": ignore_root_key,
            "pref_resolver": pref_resolver,
        }

    def get_active_mode(self):
        """
        Return active mode for local DNS server.

        Returns:
        RECURSIVE - Recursor mode
        FORWARD_UPSTREAM - forwarding to DNS server recieved from DHCP
        FORWARD_CUSTOM - forwarding to user defined DNS server
        """
        conf = self.__config
        ret = None
        if conf["forward_upstream"] is True:
            if conf["forward_custom"] is not None:
                ret = FORWARD_CUSTOM
            else:
                ret = FORWARD_UPSTREAM
        else:
            ret = RECURSIVE
        return ret

    def get_forwarder_ip(self):
        """Return two list with IPv4 and IPv6 address recieved from DHCP."""
        ipv4_list, ipv6_list = [], []
        with open(self.__resolv_path) as fp:
            for line in fp.readlines():
                if line.startswith("nameserver"):
                    _, ip = line.split()
                    try:
                        addr=ipaddress.ip_ipaddress(ip)
                        if addr.version == 4:
                            ipv4_list.append(ip)
                        else:
                            ipv6_list.append(ip)
                    except:
                        print("Error")

                    if is_valid_ipv4(ip):
                        ipv4_list.append(ip)
                    elif is_valid_ipv6(ip):
                        ipv6_list.append(ip)
        return ipv4_list, ipv6_list


class ResolverRpcd:
    """
    This class wraps up all functions available via ubus interface.

    It uses json_ubus decorator to mark method as ubus function.
    Ubus function name is then derivated from method by
    removing 'get_' prefix.
    """

    def __init__(self):
        """Init decorator registry and resolver objects."""
        self.__res_conf = ResolverConf()
        self.__res_dot = ResolverDoT()
        self.__ubus_func_list = json_ubus.registry

    def call_ubus_func(self, name):
        """Call ubus function from this class base on name."""
        for item in self.__ubus_func_list:
            if item == name:
                method_to_call = getattr(self, "get_" + name)
                method_to_call()

    def get_ubus_func_list(self):
        """Return dict with all ubus functions."""
        ret = {}
        for item in self.__ubus_func_list:
            ret.update({item: {}})
        print(json.dumps(ret))
        return ret

    @json_ubus
    def get_list_dns(self):
        """Return list of available custom DNS resolvers."""
        return self.__res_dot.get_dns_list()

    @json_ubus
    def get_active_mode(self):
        """Return which mode is used by resolver
        forward_upstream, forward_custom or recursive."""
        return self.__res_conf.get_active_mode()

    @json_ubus
    def get_config(self):
        """Return dict with resolver config."""
        return self.__res_conf.get_config()

    @json_ubus
    def get_forward_upstream_ip(self):
        """Return dict with ipv4, ipv6 list recieved via DHCP."""
        ipv4, ipv6 = self.__res_conf.get_forwarder_ip()
        return {"ipv4": ipv4, "ipv6": ipv6}

    @json_ubus
    def get_forward_custom_ip(self):
        """Return dict with ipv4/6 list if custom forwarding is selected."""
        active_method = self.__res_conf.get_active_mode()
        if active_method == FORWARD_CUSTOM:
            setting = self.__res_conf.get_config()
            name = "%s.conf" % setting["forward_custom"]
            dns_settings = self.__res_dot.get_dns(name)
            ipv4, ipv6 = dns_settings["ipv4"], dns_settings["ipv6"]
        else:
            ipv4, ipv6 = [], []
        return {"ipv4": ipv4, "ipv6": ipv6}


if __name__ == "__main__":
    res_rpcd = ResolverRpcd()
    parser = argparse.ArgumentParser(description="RPCD service for resolver")
    parser.add_argument("cmd", type=str, help="List or call rpcd command.")
    parser.add_argument("resolver_cmd", type=str, help="Resolver command.")
    parser.add_argument("--verbosity", help="Increase output verbosity.")

    if parser.cmd == "list":
        res_rpcd.get_ubus_func_list()
    elif parser.cmd == "call":
        res_rpcd.call_ubus_func(parser.resolver_cmd)
    else:
        print("Unknow command")
