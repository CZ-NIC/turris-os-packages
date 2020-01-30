# DNS over TLS


UCI configuration for DNS-over-TLS is located in **/etc/config/resolver**. You can enable redirection to custom DNS resolver by setting option **forward_custom** and enabling **forward_upstream**.

### Example:
```
uci set resolver.common.forward_custom='cloudflare-dns'
uci commit resolver
```
Where cloudflare-dns is name defined in config file from /etc/resolver/dns_servers/

Configuration files for DNS server are located in /etc/resolver/dns_servers directory and they have **config** suffix.

### Example of content of configuration file:
```
name="cloudflare-dns"
description="something something darkside..."
enable_tls="1"
port="853"
ipv4="1.1.1.1 1.0.0.1"
ipv6="2606:4700:4700::1111 2606:4700:4700::1001"
pin_sha256="yioEpqeR4WtDwE9YxNVnCEkTxIjx6EEIwFSQW+lJsbc="
```

Variables in config file have this meaning:
 - name - resolver name (used in Foris)
 - description - longer description of server
 - enable_tls - 1/0=forward with/without enabled TLS
 - port - server port with DNS-over-TLS service
 - ipv4 - primary IPv4 address, secondary IPv4 address separated with space
 - ipv6 - primary IPv6 address, secondary IPv6 address separated with space
 - pin_sha256 - sha256 pin see [rfc7858](https://tools.ietf.org/html/rfc7858#section-4.2)

> Note: Config files shouldn't be modified by users because they'll be rewrited after every update.

If you want to edit the configuration for a particular server, you should create a new config file in **/etc/resolver/dns_server** with a different name than config files provided by this package.

### How to show configuration

If you want to show final configuration, you should use ubus rpcd service resolver_rpcd.py (more information about ubus is available  here https://wiki.openwrt.org/doc/techref/ubus )
```
ubus call resolver_rpcd.py list_dns '{}'
```
You will get ouput in json format similar to this:
```
{
        "list_dns": [
                {
                        "description": "nejaky suer defined popis cloudflare-dn,
                        "pin_sha256": "yioEpqeR4WtDwE9YxNVnCEkTxIjx6EEIwFSQW+lJ,
                        "hostname": "cloudflare-dns.com",
                        "ipv4": "1.1.1.1",
                        "ipv6": "2606:4700:4700::1111",
                        "enable_tls": "1",
                        "port": "853",
                        "name": "cloudflare-dns"
                },
                {
                        "ipv6": "2001:148f:ffff::1",
                        "ipv4": "193.17.47.1",
                        "name": "ODVR NIC.CZ",
                        "description": "CZ.NIC DNS resolvers"
                },
                {
                        "ipv4": "89.233.43.71",
                        "pin_sha256": "wikE3jYAA6jQmXYTr\/rbHeEPmC78dQwZbQp6Wdr,
                        "enable_tls": "1",
                        "hostname": "unicast.censurfridns.dk",
                        "port": "853",
                        "name": "unicast.censurfridns.dk"
                }
        ]
}
```

## Difference between Knot-resolver an Unbound
### Knot-resolver
Knot-resolver support **pin sha256** and **CA** authentication. Preferred and default authentication is **CA** authentication.

Note: If you want to get pin sha256 from DNS resolver use this command __(9.9.9.9 is DNS resolver IP)__. For more information about pin see [rfc 7858](https://tools.ietf.org/html/rfc7858#section-4.2)
```
echo | openssl s_client -connect '9.9.9.9:853' 2>/dev/null | openssl x509 -pubkey -noout | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64
```

### Unbound
Unfortunately, Unbound doesn't support pin authentication, yet. Default option is CA authentication. This is done by setting **ca_file** and **hostname** option in **/etc/resolver/dns_server/*.config** config.


