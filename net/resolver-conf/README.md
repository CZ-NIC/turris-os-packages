# DNS over TLS


UCI configuration for DNS-over-TLS is located in **/etc/config/resolver**. You can enable redirection to custom DNS resolver by setting option **forward_custom**.

### Example:
```
uci set resolver.common.forward_custom='cloudflare-dns'
uci commit resolver
```
Where  cloudflare-dns is name defined in config file from /etc/resolver/dns_servers or name defined in dns_server config section in /etc/config/resolver

Configuration files for DNS server are located in /etc/resolver/dns_servers directory and they have **config** suffix.

### Example of content of configuration file:
```
name="cloudflare-dns"
description="something something darkside..."
enable_tls="1"
port="853"
ipv4="1.1.1.1"
ipv6="2606:4700:4700::1111"
pin_sha256="yioEpqeR4WtDwE9YxNVnCEkTxIjx6EEIwFSQW+lJsbc="
```

> Note: Config files shouldn't be modified by users because they'll be rewrited after every update.

If you want to edit configuration for a particular server you should create **dns_server** section **/etc/config/resolver** with same name as is defined in config file and change value of desired variable. System will prefere option set inside UCI config.

### Example of new section inside /etc/config/resolver
```
config dns_server
	option name 'cloudflare-dns'
	option port "888"
```
This will change port to 888 other options will be read from /etc/resolver/dns_server/*.config file.



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
                        "ipv6": "2001:1488:800:400::130",
                        "ipv4": "217.31.204.130",
                        "name": "ODVR NIC.CZ",
                        "description": "DNS resolvery cznic"
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
Knot-resolver support **pin sha256** and **CA** authentication. Preferred and default authentication is **pin sha256**. If you want to use CA authentication you have to add **hostname** and **ca_file** options to /etc/resolver/dns_servers/*.config or create new section in /etc/config/resolver.

Note: If you want to get pin sha256 from DNS resolver use this command __(9.9.9.9 is DNS resolver IP)__. For more information about pin see [rfc 7858](https://tools.ietf.org/html/rfc7858#section-4.2)
```
echo | openssl s_client -connect '9.9.9.9:853' 2>/dev/null | openssl x509 -pubkey -noout | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64
```

### Unbound
Unbound at this moment (v 1.7.3) doesn't support pin authentication. Default option is CA authentication. This is done by setting **ca_file** and **hostname** option in **/etc/resolver/dns_server/*.config** config.
It's also possible to set Unbound to use **opportunistic DNS-over-TLS encryption**, however in that case traffic is secured only agains passive atacker and active attack are still posible.
