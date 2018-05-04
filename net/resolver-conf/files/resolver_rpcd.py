#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 24 14:52:08 2018

@author: cz_nic
"""
import subprocess
import os
from os import listdir
from os.path import isfile, join
import json
import copy
import sys
import syslog


DNS_SERVERS_DIR = "/etc/resolver/dns_servers/"


def call_cmd(cmd):
    assert isinstance(cmd, list)
    task = subprocess.Popen(cmd, shell=False,
                            stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)
    data = task.stdout.read()
    return data


def uci_show(path):
    return call_cmd(["uci", "show", "%s" % path]).rstrip()


def get_uci_dns_servers():
    ret_arr = []
    for i in range(100):
        config = uci_show("resolver.@dns_server[%i]" % i)
        ret = {}
        if config.find("Entry not found") >= 0:
            return {}
        for item in config.splitlines():
            tmp_arr = item.split("=", 1)
            if len(tmp_arr) == 2:
                tmp_var = tmp_arr[0].split(".")
                if len(tmp_var) == 3:
                    ret.update({tmp_var[-1]: tmp_arr[1].strip("'\"")})
        if "name" in ret:
            ret_arr.append(ret)
    return ret_arr


def get_config(filename):
    ret = {}
    with open(filename) as fp:
        for item in fp.readlines():
            line = item.split("#")[0]  # remove comments
            arr = line.split("=", 1)
            if len(arr) == 2:
                # remove quotation marks
                ret.update({arr[0].strip(" '\"\n\'"): arr[1].strip(" '\"\n\'")})
        if not("name" in ret):
            return {}
    return ret


def get_file_configs(path, extension="conf"):
    ret_arr = []
    configs_path = get_file_list(path, extension).get("full_path")
    for path in configs_path:
        ret_arr.append(get_config(path))
    return ret_arr


def get_file_list(mypath, extension="sh"):
    if os.path.isdir(mypath):
        tmp_files = [f for f in listdir(mypath) if isfile(join(mypath, f)) and f.endswith("."+extension)]
        tmp_full = [os.path.join(mypath, f) for f in tmp_files]
        return {"files": tmp_files, "full_path": tmp_full}
    else:
        return {"files": [], "full_path": []}


def get_dns_list(arg1):
    file_configs = get_file_configs(DNS_SERVERS_DIR)
    uci_configs = get_uci_dns_servers()

    tmp = []
    for config_file in file_configs:
        for config_uci in uci_configs:
            if config_uci.get("name") == config_file.get("name"):
                tmp_config = copy.deepcopy(config_file)
                tmp_config.update(config_uci)  # update uci
                tmp.append(tmp_config)
                uci_configs.remove(config_uci)
                file_configs.remove(config_file)

    if file_configs != []:
        tmp += file_configs

    if uci_configs != []:
        tmp += uci_configs
    return json.dumps({"list_dns": tmp})


if __name__ == "__main__":
    if len(sys.argv) > 1:
        if sys.argv[1] == "list":
            print(json.dumps({"list_dns": {}}))
        elif sys.argv[1] == "call":
            print(get_dns_list(sys.argv[2]))
        else:
            syslog.syslog("Unknown argument.")
