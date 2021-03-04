--[[
This file is part of package pkglists. Don't edit it.
]]

if uci then

	local uci_cursor = uci.cursor(root_dir .. "/etc/config")

	local pkglists = uci_cursor:get("pkglists", "pkglists", "pkglist")

	-- If not pkglists were requested then we are done
	if pkglists == nil then
		return
	end

	-- If there is single list then uci returns just a string
	if type(pkglists) == "string" then
		pkglists = {pkglists}
	end
	-- Convert pkglists to set set of lists (ensures uniqueness) and add options
	local lists = {}
	for _, list in pairs(pkglists) do
		lists[list] = uci_cursor:get_all("pkglists", list) or {}
		for opt, value in pairs(lists[list]) do
			lists[list][opt] = value == "1" or value == "yes" or value == "on" or value == "true" or value == "enabled"
		end
	end

	-- Verify existence of lists
	local json_available, json = pcall(require, "json")
	if json_available then
		local deff = io.open(root_dir .. "/usr/share/updater/pkglists.json")
		local defined = json.decode(deff:read("*a"))
		deff:close()
		for name in pairs(lists) do
			if not defined[name] then
				WARN("Package list is not defined, ignoring: " .. name)
				lists[name] = nil
			end
		end
	end

	-- Some duplicate code from updater-ng package to get base_url
	local mode = uci_cursor:get("updater", "turris", "mode") or "branch"
	local branch = uci_cursor:get("updater", "turris", "branch") or "hbs"
	local version = uci_cursor:get("updater", "turris", "version") or nil
	local product = os_release["OPENWRT_DEVICE_PRODUCT"] or os_release["LEDE_DEVICE_PRODUCT"]
	if product:match("[Mm]ox") then
		board = "mox"
	elseif product:match("[Oo]mnia") then
		board = "omnia"
	elseif product:match("[Tt]urris 1.x") then
		board = "turris1x"
	else
		DIE("Unsupported Turris board: " .. tostring(product))
	end
	Export('board')
	local base_url
	if mode == "branch" then
		base_url = "https://repo.turris.cz/" .. branch .. "/" .. board .. "/lists/pkglists/"
	elseif mode == "version" then
		base_url = "https://repo.turris.cz/archive/" .. version .. "/" .. board .. "/lists/pkglists/"
	else
		DIE("Invalid updater.turris.mode specified: " .. mode)
	end
	local script_options = {
		security = "Remote",
		pubkey = {
			"file:///etc/updater/keys/release.pub",
			"file:///etc/updater/keys/standby.pub",
			"file:///etc/updater/keys/test.pub" -- It is normal for this one to not be present in production systems
		}
	}

	options = {}
	Export("options")
	for l, opts in pairs(lists) do
		options = opts
		Script(base_url .. l .. ".lua", script_options)
	end

else
	WARN("UCI library is not available. No package list included.")
end
