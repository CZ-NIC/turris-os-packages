#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 24 14:52:08 2018

@author: cz_nic

This script is used for rpcd ubus service.
It servers DNS resolver settings for DNS over TLS in json.
It should be located in /usr/libexec/rpcd

Example:
    ubus call resolver_rpcd.py list_dns '{}'

"""
import subprocess
import os
from os import listdir
from os.path import isfile, join
import json
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
    return json.dumps({"list_dns": file_configs})


if __name__ == "__main__":
    if len(sys.argv) > 1:
        if sys.argv[1] == "list":
            print(json.dumps({"list_dns": {}}))
        elif sys.argv[1] == "call":
            print(get_dns_list(sys.argv[2]))
        else:
            syslog.syslog("Unknown argument.")
