local util = require "luci.util"
local uci = require "luci.model.uci".cursor()

function test_deckard_forwarder(forwarder_ip)
	local ret = util.ubus(	"xml_parser.py",
				"test_forwarder",
				{forwarder=forwarder_ip})
	return ret["status"]
end


function test_deckard_network()
	local ret = util.ubus(	"xml_parser.py",
				"test_network",
				{})
	return ret["status"]
end


function get_dns_servers()
	local ret = util.ubus("xml_parser.py",
				"get_dns_list",
				{})
	return ret["status"]
end


m = Map("cbi_file", translate("DNS Resolver Debugger"),
        translate("This app should help you debug DNS resolver on your network"))
d = m:section(TypedSection, "info", " ")


d:tab("deckard",translate("Test local DNS settings"))

mode = d:taboption("deckard", ListValue, "mode", translate("DNS Resolver"))
dns_list=get_dns_servers()
for key,value in pairs(dns_list) do
	mode:value(value["ipaddr"], translate(value["name"] .. " - " .. value["ipaddr"]))
end
mode.default = "auto"

f = d:taboption("deckard", Flag, "_check_network", "Test network")
f.default = 0

sf = d:taboption("deckard", Flag, "_check_show_failed", "Show only failed tests")
sf.default = 1

btn_download_log = d:taboption("deckard",Button, "_btn_download_log", translate("Download log"))

function btn_download_log.write()
	luci.http.prepare_content("text/plain")
	luci.http.write("Haha, rebooting now...")
	--luci.sys.reboot()
	return
end


btn_test_domain = d:taboption("deckard",Button, "_btn_test_domain", translate("Run DNS tests"))

function btn_test_domain.write()
	local forwarder = luci.http.formvalue("cbid.cbi_file.A.mode")
	local only_failed=luci.http.formvalue("cbid.cbi_file.A._check_show_failed")
	local test_network=luci.http.formvalue("cbid.cbi_file.A._check_network")

	local ret_tmp
	local ret
	local ret_net
	local tbl_tests
	local tbl_stats
	local test_status
	local tbl_net_tests
	local tbl_net_stats

	ret_net=test_deckard_network()
	ret_net_stats=ret_net["stats"]
	ret_net_tests=ret_net["tests"]

	ret = test_deckard_forwarder(forwarder)
	ret_stats=ret["stats"]
	ret_tests=ret["tests"]


	tbl_stats= '<h2>Test statistics</h2><table style="table-layout:fixed;width: 400px;">\n'
	tbl_stats= tbl_stats .. '<tr><th>Number of tests (forwarder)</th><td>' .. ret_stats["tests"] .. '</td></tr>'
	tbl_stats= tbl_stats .. '<tr><th>Failed tests (forwarder)</th><td>' .. ret_stats["failures"] .. '</td></tr>'
	if test_network == "1" then
		tbl_stats= tbl_stats .. '<tr><th>Number of tests (network)</th><td>' .. ret_net_stats["tests"] .. '</td></tr>'
		tbl_stats= tbl_stats .. '<tr><th>Failed tests (network)</th><td>' .. ret_net_stats["failures"] .. '</td></tr>'
	end
	tbl_stats = tbl_stats .. "</table>"

	tbl_tests=  '<h2>Test results (forwarder)</h2><table style="table-layout:fixed;width: 800px;">\n<tr><th>Test name</th><th>Status</th></tr>'
	for key,value in pairs(ret_tests) do

		if tostring(value["failed"]) == "true" then
			test_status = '<span style="color:red">Failed</span>'
		else
			test_status = '<span style="color:green">OK</span>'
		end

    		if only_failed == "1" then
			if tostring(value["failed"]) == "true" then
				tbl_tests = tbl_tests .. "<tr><td>" .. value["name"] .. "</td><td>" .. test_status .. "</td></tr>\n"
			end
		else
			tbl_tests = tbl_tests .. "<tr><td>" .. value["name"] .. "</td><td>" .. test_status .. "</td></tr>\n"
		end
	end
	tbl_tests=tbl_tests .. "</table>"
	if test_network == "1" then
		tbl_tests=tbl_tests ..  '<h2>Test results (network)</h2><table style="table-layout:fixed;width: 800px;">\n<tr><th>Test name</th><th>Status</th></tr>'
		for key,value in pairs(ret_net_tests) do

			if tostring(value["failed"]) == "true" then
				test_status = '<span style="color:red">Failed</span>'
			else
				test_status = '<span style="color:green">OK</span>'
			end

			if only_failed == "1" then
				if tostring(value["failed"]) == "true" then
					tbl_tests = tbl_tests .. "<tr><td>" .. value["name"] .. "</td><td>" .. test_status .. "</td></tr>\n"
				end
			else
				tbl_tests = tbl_tests .. "<tr><td>" .. value["name"] .. "</td><td>" .. test_status .. "</td></tr>\n"
			end
		end
		tbl_tests=tbl_tests .. "</table>"
	end


	--local aaa=uci:get("resolver", "common", "forward_upstream")

	luci.template.render("dns-diagnostics/view_tab", {tbl_stat=tbl_stats,tbl_results=tbl_tests})
end


return m
