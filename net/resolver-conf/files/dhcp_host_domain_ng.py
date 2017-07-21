#!/usr/bin/python

import subprocess
import sys
import syslog
from syslog import LOG_ERR, LOG_INFO, LOG_DEBUG, LOG_WARNING


def log(text, priority=LOG_INFO):
    syslog.syslog(priority, text)
    print text


def call_cmd(cmd):
    task = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    data = task.stdout.read()
    return data


def call_pidof(process):
    pid = call_cmd("pidof %s" % process).strip()
    if pid.isdigit():
        return int(pid)
    else:
        return None


def uci_get(path):
    return call_cmd("uci get %s" % path)

def uci_get_bool(path):
    ret=uci_get(path).rstrip()
    if ret == "1" or ret.lower() == "true":
        return True
    else:
        return False

def uci_set(path, val):
    call_cmd("uci set %s=%s" % (path, val))


class Kresd:
    def __init__(self,
                 dhcp_dynamic_leases="/tmp/dhcp.leases.dynamic",
                 dhcp_static_leases="/tmp/kresd/hints.tmp",
                 empty_file="/tmp/dhcp.empty"):
        self.__empty_file = empty_file
        self.__static_leases = dhcp_static_leases
        self.__dynamic_leases = dhcp_dynamic_leases
        self.__static_leases_enabled = uci_get_bool("resolver.common.static_domains")
        self.__dynamic_leases_enabled = uci_get_bool("resolver.common.dynamic_domains")

    def __call_kresd(self, cmd):
        pid_kresd = call_pidof("kresd")
        return call_cmd("%s | socat - UNIX-CONNECT:/tmp/kresd/tty/%i > /dev/null 2>&1" % (cmd, pid_kresd))

    def __clean_hints(self):
        open(self.__empty_file, "a").close()
        # load empty file to clear kresd hints
        self.__call_kresd("echo hints.config('%s')" % self.__empty_file)

    def refresh_leases(self):
        self.__clean_hints()
        if self.__static_leases_enabled:
            self.__call_kresd("echo \"hints.add_hosts('%s')\"" % self.__static_leases)
        if self.__dynamic_leases_enabled:
            self.__call_kresd("echo \"hints.add_hosts('%s')\"" % self.__dynamic_leases)


class Unbound:
    def refresh_leases(self):
        call_cmd("/etc/init.d/resolver restart")


class DHCPv4:
    def __init__(self, dhcp_leases="/tmp/dhcp.leases", dhcp_leases_out="/tmp/dhcp.leases.dynamic"):
        self.__dhcp_leases_file = dhcp_leases
        self.__dhcp_leases_out_file = dhcp_leases_out
        self.__leases_list = []
        self.__resolver = uci_get("resolver.common.prefered_resolver").rstrip()
        self.__local_suffix = uci_get("dhcp.@dnsmasq[0].local").rstrip().replace("/", "")
        self.__load_hints()

    def update_dhcp(self, op, hostname, ipv4):
        if op == "add":
            self.__add_lease(hostname, ipv4)
            log("DHCP add new hostname [%s,%s]" % (hostname, ipv4), LOG_INFO)
        elif op == "del":
            self.__del_lease(hostname, ipv4)
            log("DHCP delete hostname [%s,%s]" % (op, hostname, ipv4), LOG_INFO)
        elif op == "old":
            self.__del_lease(hostname, ipv4)
            log("DHCP remove old hostname [%s,%s]" % (op, hostname, ipv4), LOG_INFO)
        else:
            log("DHCP unknown update operation", LOG_WARNING)

    def save_leases(self, overwrite=True):
        with open(self.__dhcp_leases_out_file, "w") as fp:
            for item in self.__leases_list:
                hostname, ipv4 = item
                fp.write("%s %s\n" % (ipv4, hostname))

    def refresh_resolver(self):
        if self.__resolver == "kresd":
            tmp_res = Kresd()
            tmp_res.refresh_leases()
            log("Refresh kresd leases", LOG_INFO)
        elif self.__resolver == "unbound":
            tmp_res = Unbound()
            tmp_res.refresh_leases()
            log("Refresh unbound leases", LOG_INFO)
        else:
            log("Refresh failed. Unknown resolver", LOG_WARNING)

    def __load_hints(self):
        try:
            with open(self.__dhcp_leases_file, "r") as fp:
                for line in fp.read().splitlines():
                    if len(line.split()) >= 4:
                        timestamp, mac, ipv4, hostname = line.split()[:4]
                        self.__add_lease(hostname, ipv4)
        except IOError:
            log("DHCP leases file does not exist %s " % 
                self.__dhcp_leases_file, LOG_WARNING)

    def __add_lease(self, hostname, ipv4):
        if self.__check_hostname(hostname):
            # hostname with suffix
            hostname_suffix = "%s.%s" % (hostname, self.__local_suffix)
            for index, item in enumerate(self.__leases_list):
                if item[0] == hostname_suffix:
                    self.__leases_list[index][1] = ipv4
                    return
            self.__leases_list.append([hostname_suffix, ipv4])

    def __del_lease(self, hostname, ipv4=None):
        hostname_suffix = "%s.%s" % (hostname, self.__local_suffix)
        if self.__check_hostname(hostname):
            for index, item in enumerate(self.__leases_list):
                if item[0] == hostname_suffix:
                    self.__leases_list.remove(self.__leases_list[index])

    def __check_hostname(self, hostname):
        if hostname != "" and not(hostname.isspace()) and hostname != "*":
            return True
        else:
            log("Hostname check failed", LOG_WARNING)
            return False

if __name__ == "__main__":
    if len(sys.argv) == 2 and sys.argv[1] == "ipv6":
        log("DHCPv6 leases not supported now", LOG_WARNING)
    elif len(sys.argv) > 4:
        log("DHCPv4 new lease", LOG_INFO)
        sys_op = sys.argv[1]
        mac = sys.argv[2]
        ipv4 = sys.argv[3]
        hostname = sys.argv[4]
        dd = DHCPv4()
        dd.update_dhcp(sys_op, hostname, ipv4)
        dd.save_leases()
        dd.refresh_resolver()
    else:
        dd = DHCPv4()
        dd.save_leases()
        dd.refresh_resolver()
