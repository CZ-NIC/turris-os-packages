#!/usr/bin/python

import subprocess
import sys
import syslog
from syslog import LOG_ERR, LOG_INFO, LOG_DEBUG, LOG_WARNING
import re
import socket
import os
from os import listdir


def is_valid_hostname(hostname):
    if len(hostname) > 255:
        return False
    if hostname == "":
        return False
    if hostname[-1] == ".":
        hostname = hostname[:-1]
    allowed = re.compile("(?!-)[A-Z\d-]{1,63}(?<!-)$", re.IGNORECASE)
    for x in hostname.split("."):
        if allowed.match(x) is None:
            return False
    return True


def is_valid_ipv4(address):
    try:
        socket.inet_pton(socket.AF_INET, address)
    except AttributeError:  # no inet_pton here, sorry
        try:
            socket.inet_aton(address)
        except socket.error:
            return False
        return address.count('.') == 3
    except socket.error:  # not a valid
        return False
    return True


def is_valid_ipv6(address):
    try:
        socket.inet_pton(socket.AF_INET6, address)
    except socket.error:  # not a valid
        return False
    return True


def log(text, priority=LOG_INFO, output="syslog"):
    if output is "syslog":
        syslog.syslog(priority, text)
    else:
        print(text)


def call_cmd(cmd):
    assert isinstance(cmd, list)
    task = subprocess.Popen(cmd, shell=False, stdout=subprocess.PIPE)
    data = task.stdout.read()
    return data


def uci_get(path):
    return call_cmd(["uci", "get", "%s" % path]).rstrip()


def uci_get_bool(path, default):
    ret = uci_get(path)
    if ret in ('1', 'on', 'true', 'yes', 'enabled'):
        return True
    elif ret in ('0', 'off', 'false', 'no', 'disabled'):
        return False
    else:
        return default


def uci_set(path, val):
    return call_cmd(["uci", "set", "%s=%s" % (path, val)])


class Kresd:
    def __init__(self,
                 dhcp_dynamic_leases="/tmp/dhcp.leases.dynamic",
                 dhcp_static_leases="/tmp/kresd/hints.tmp",
                 empty_file="/tmp/dhcp.empty"):
        self.__empty_file = empty_file
        self.__static_leases = dhcp_static_leases
        self.__dynamic_leases = dhcp_dynamic_leases
        self.__static_leases_enabled = uci_get_bool("resolver.common.static_domains", True)
        self.__dynamic_leases_enabled = uci_get_bool("resolver.common.dynamic_domains", False)
        self.__socket_path = self._get_socket_path()

    def _get_socket_path(self):
        path = os.path.join(uci_get("resolver.kresd.rundir"), "tty")
        try:
            files = [f for f in listdir(path)]
            return os.path.join(path, files[0])
        except:
            log("Kresd is probably not running no socket found.", LOG_ERR)
            sys.exit(1)

    def _remove_hints_hosts(self, filename):
        with open(filename, "r") as handle:
            for line in handle:
                line = line.strip()
                if not line or line.startswith("#"):
                    continue
                try:
                    host = line.strip().split()[1]
                    self._call_kresd("hints.del('%s')" % host)
                except:
                    log("Wrong host format '%s' in host file %s " %
                        (filename, line), LOG_ERR)

    def _clean_hints(self):
        # clear kresd hints
        if self.__static_leases_enabled:
            self._remove_hints_hosts(self.__static_leases)
        if self.__dynamic_leases_enabled:
            self._remove_hints_hosts(self.__dynamic_leases)

    def _call_kresd(self, cmd):
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        sock.settimeout(2)
        try:
            sock.connect(self.__socket_path)
            sock.sendall(cmd + "\n")
            ret = sock.recv(4096)
            sock.close()
            return ret
        except socket.error as msg:
            log("Kresd socket failed:%s,%s" % (socket.error, msg), LOG_ERR)
            sys.exit(1)

    def refresh_leases(self):
        self._clean_hints()
        if self.__static_leases_enabled:
            self._call_kresd("hints.add_hosts('%s')" % self.__static_leases)
        if self.__dynamic_leases_enabled:
            self._call_kresd("hints.add_hosts('%s')" % self.__dynamic_leases)


class Unbound:
    def __init__(self,
                 dhcp_dynamic_leases="/tmp/dhcp.leases.dynamic",
                 static_leases="/var/etc/unbound/static.leases"):
        # check if files exists.....
        self.__dhcp_dynamic_leases = dhcp_dynamic_leases
        self.__static_leases = static_leases
        self.__dynamic_leases_enabled = uci_get_bool("resolver.common.dynamic_domains", False)
        self.__static_leases_enabled = uci_get_bool("resolver.common.static_domains", False)
        self.__local_suffix = uci_get("dhcp.@dnsmasq[0].local").replace("/", "")

    def _call_unbound(self, cmd, arg=""):
        if arg == "":
            ret = call_cmd(["unbound-control", cmd])
        else:
            ret = call_cmd(["unbound-control", cmd, arg])
        return ret

    def _get_unbound_list(self, unbound_list, filter_local, suffix):
        """ list_local_data, list_local_zones """
        ret = []
        cmd_ret = self._call_unbound(unbound_list)
        for item in filter(None, cmd_ret.splitlines()):
            item_list = item.split()
            if filter_local:
                if item_list[0].endswith("." + suffix + "."):
                    ret.append(item_list)
            else:
                ret.append(item_list)
        return ret

    def _get_static_leases(self):
        ret = []
        with open(self.__static_leases, "r") as fp:
            for line in fp.read().splitlines():
                if not line.startswith("#"):
                    line = " ".join(line.split())  # remove multiple white spaces
                    items = line.split()
                    if len(items) >= 2:
                        ret.append(items[:2])  # insert only first items
        return ret

    def _get_dynamic_leases(self):
        ret = []
        with open(self.__dhcp_dynamic_leases, "r") as fp:
            for line in fp.read().splitlines():
                ret.append(line.split())
        return ret

    def _add_local_zone(self, domain):
        domain = self._fix_domain(domain)
        ret = self._call_unbound("local_zone", "%s static" % domain)
        return ret

    def _add_local_data(self, domain, ip):
        domain = self._fix_domain(domain)
        ret = self._call_unbound("local_data", "%s IN A %s" % (domain, ip))
        return ret

    def _fix_domain(self, domain):
        if not domain.endswith("."):
            domain = domain + "."
        return domain

    def _remove_local(self, local_type, domain):
        """local_zone_remove ,local_data_remove"""
        domain = self._fix_domain(domain)
        ret = self._call_unbound(local_type, "%s" % domain).strip()
        if ret == "ok":
            return True
        else:
            return False

    def _remove_local_data(self, domain):
        return self._remove_local("local_data_remove", domain)

    def _remove_local_zone(self, domain):
        return self._remove_local("local_zone_remove", domain)

    def refresh_leases(self):
        self._clean_leases()
        domain_list = []
        if self.__static_leases_enabled:
            domain_list += self._get_static_leases()
        if self.__dynamic_leases_enabled:
            domain_list += self._get_dynamic_leases()
        if domain_list:
            for ip, domain in domain_list:
                self._add_local_zone(domain)
                self._add_local_data(domain, ip)

    def _clean_leases(self):
        local_zones_list = self._get_unbound_list("list_local_zones",
                                                  filter_local=True,
                                                  suffix="lan")
        local_data_list = self._get_unbound_list("list_local_data",
                                                 filter_local=True,
                                                 suffix="lan")
        for item in local_zones_list:
            domain = item[0]
            self._remove_local_zone(domain)
        for item in local_data_list:
            domain = item[0]
            self._remove_local_data(domain)


class DHCPv4:
    def __init__(self, dhcp_leases="/tmp/dhcp.leases", dhcp_leases_out="/tmp/dhcp.leases.dynamic"):
        self.__dhcp_leases_file = dhcp_leases
        self.__dhcp_leases_out_file = dhcp_leases_out
        self.__leases_list = []
        self.__resolver = uci_get("resolver.common.prefered_resolver")
        self.__local_suffix = uci_get("dhcp.@dnsmasq[0].local").replace("/", "")
        self._load_hints()

    def update_dhcp(self, op, hostname, ipv4):
        if op == "add":
            self._add_lease(hostname, ipv4)
            log("DHCP add new hostname [%s,%s]" % (hostname, ipv4), LOG_INFO)
        elif op == "del":
            self._del_lease(hostname, ipv4)
            log("DHCP delete hostname [%s,%s,%s]" % (op, hostname, ipv4), LOG_INFO)
        elif op == "old":
            self._add_lease(hostname, ipv4)
            log("DHCP update hostname [%s,%s,%s]" % (op, hostname, ipv4), LOG_INFO)
        else:
            log("DHCP unknown update operation", LOG_WARNING)

    def save_leases(self, overwrite=True):
        with open(self.__dhcp_leases_out_file, "w") as fp:
            for item in self.__leases_list:
                hostname, ipv4 = item
                fp.write("%s %s\n" % (ipv4, hostname))

    def refresh_resolver(self):
        if self.__resolver == "kresd":
            static_leases = os.path.join(uci_get("resolver.kresd.rundir"), "hints.tmp")
            tmp_res = Kresd(dhcp_static_leases=static_leases)
            tmp_res.refresh_leases()
            log("Refresh kresd leases", LOG_INFO)
        elif self.__resolver == "unbound":
            tmp_res = Unbound()
            tmp_res.refresh_leases()
            log("Refresh unbound leases", LOG_INFO)
        else:
            log("Refresh failed. Unknown resolver", LOG_WARNING)

    def _load_hints(self):
        try:
            with open(self.__dhcp_leases_file, "r") as fp:
                for line in fp.read().splitlines():
                    if len(line.split()) >= 4:
                        timestamp, mac, ipv4, hostname = line.split()[:4]
                        self._add_lease(hostname, ipv4)
        except IOError:
            log("DHCP leases file does not exist %s " %
                self.__dhcp_leases_file, LOG_WARNING)

    def _add_lease(self, hostname, ipv4):
        if is_valid_hostname(hostname) is False:
            log("Add_lease, hostname check failed", LOG_WARNING)
            return False
        if is_valid_ipv4(ipv4) is False:
            log("Add_lease, ipv4 check failed", LOG_WARNING)
            return False
        # hostname with suffix
        hostname_suffix = "%s.%s" % (hostname, self.__local_suffix)
        for index, item in enumerate(self.__leases_list):
            if item[0] == hostname_suffix:
                self.__leases_list[index][1] = ipv4
                return True
        self.__leases_list.append([hostname_suffix, ipv4])
        return True

    def _del_lease(self, hostname, ipv4=None):
        hostname_suffix = "%s.%s" % (hostname, self.__local_suffix)
        if is_valid_hostname(hostname) is False:
            log("Del_lease, hosname check failed", LOG_WARNING)
            return False
        for index, item in enumerate(self.__leases_list):
            if item[0] == hostname_suffix:
                del self.__leases_list[index]
                break
        return True


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
        # get env variables in case of
        # call from dnsmasq dhcp-script.sh
        sys_op = os.environ.get('ACTION')
        mac = os.environ.get('MACADDR')
        ipv4 = os.environ.get('IPADDR')
        hostname = os.environ.get('HOSTNAME')
        dd = DHCPv4()
        if sys_op and hostname and ipv4:
                dd.update_dhcp(sys_op, hostname, ipv4)
        dd.save_leases()
        dd.refresh_resolver()
