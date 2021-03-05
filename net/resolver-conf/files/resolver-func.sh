
DNS_CONFIG_DIR="/etc/resolver/dns_servers"

echoerr() {
	echo "$@" 1>&2
}

load_variable() {
	local config_name="$1"
	local var_name="$2"
	local var_required="$3"

	local ret="$(awk -v opt="$var_name" -v OFS== -F = '$1 == opt { $1=""; gsub(/^="?|"$/, ""); print }' "$config_name")"

	if [ -z "${ret// }" ] && [ "$var_required" == 1 ]; then
		echoerr "Error! Required variable $var_name not defined in $config_name"
		exit 1
	fi

	echo -ne $ret
}

get_dns_ip() {
	local ipv4="$1"
	local ipv6="$2"
	local net_ipv4="$3"
	local net_ipv6="$4"

	if [ "$net_ipv4" = 1 ]; then
		ip_list="$ipv4"
	fi
	if [ "$net_ipv6" = 1 ]; then
		ip_list="$ip_list${ip_list:+ }$ipv6"
	fi
	if [ -z "${ip_list// }" ]; then
		echoerr "No suitable IP address configured"
		exit 1
	fi

	# return ip_list
	echo "$ip_list"
}

dns_config_load() {
	local config_name="$1"
	local resolver_callback="$2"

	local config_file
	config_file="$DNS_CONFIG_DIR/${config_name}.conf"
	config_load resolver

	#check file config file
	if [ -f "$config_file" ]; then
		local enable_tls="0" #set default value
		local net_ipv6 net_ipv4
		config_get_bool net_ipv6 "common" "net_ipv6" 1
		config_get_bool net_ipv4 "common" "net_ipv4" 1

		# load variables from config file
		local name="$(load_variable "$config_file" name 1)"
		local description="$(load_variable "$config_file" description 1)"
		local port="$(load_variable "$config_file" port 1)"
		local ipv4="$(load_variable "$config_file" ipv4 0)"
		local ipv6="$(load_variable "$config_file" ipv6 0)"
		local enable_tls="$(load_variable "$config_file" enable_tls 0)"
		local pin_sha256="$(load_variable "$config_file" pin_sha256 0)"
		local hostname="$(load_variable "$config_file" hostname 0)"
		local ca_file="$(load_variable "$config_file" ca_file 0)"

		if [ "$enable_tls" == "1" ];then
			if [ -z "${pin_sha256// }" ]  && ([ -z "${hostname// }" ] || [ -z "${ca_file// }"   ] ); then
				echoerr "Error! $config_name does not contain variables for DNS over TLS!"
				exit 1
			fi
		fi

		ip_list="$(get_dns_ip "$ipv4" "$ipv6" "$net_ipv4" "$net_ipv6")"

		#call callback function
		$resolver_callback "$ip_list" "$enable_tls" "$port" "$pin_sha256" "$hostname" "$ca_file"
	else
		echoerr "Error DNS Resolver config not found!"
	fi
}

get_servers_ip_addresses() {
	local ipv4_enabled="$1"
	local ipv6_enabled="$2"
	local resolv_conf="$3"
	local max_ip="$4"
	local i=0

	# Limit maximum number of returned IP addresses to $max_ip
	awk '$1 == "nameserver" {print $2}' "$resolv_conf" \
		| while [ "$i" -lt "$max_ip" ] && read -r ip; do
			if [ "$ipv4_enabled" = "1" ] && ipcheck.py -4 -c "$ip"; then
				printf "$ip "
				i=$((i+1))
			elif [ "$ipv6_enabled" = "1" ] && ipcheck.py -6 -c "$ip"; then
				printf "$ip "
				i=$((i+1))
			fi
		done
}
