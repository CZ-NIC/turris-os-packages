#!/usr/bin/env python3
"""
Utility to check validity of IPv4 and IPv6 address
"""
import argparse
import ipaddress
import sys


def get_ip_version(ip, ipv4_enabled=False, ipv6_enabled=False):
    try:
        addr = ipaddress.ip_address(ip)
    except ValueError:
        return None

    if addr.version == 4 and ipv4_enabled:
        return ip
    elif addr.version == 6 and ipv6_enabled:
        return ip
    return None


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Utility to check validity of IPv4 and IPv6 address")
    parser.add_argument("-c", "--check", required=True,
                        help="Check validity of IP")
    parser.add_argument('-4', '--ipv4', action='store_true',
                        help="Specify IPv4 address family")
    parser.add_argument('-6', '--ipv6', action='store_true',
                        help="Specify IPv6 address family")

    args = parser.parse_args()
    # In case that no IP argument was passed check validity for IPv4 and IPv6
    if not args.ipv4 and not args.ipv6:
        args.ipv4, args.ipv6 = True, True

    check_ip = get_ip_version(args.check, args.ipv4, args.ipv6)
    sys.exit(0 if check_ip else 1)
