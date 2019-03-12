--[[
This file is part of updater-ng. Don't edit it.
]]

local branch = ""
local lists
local datacollection_enabled = false
if uci then
	local cursor = uci.cursor()
	branch = cursor:get("updater", "override", "branch")
	if branch then
		WARN("Branch overriden to " .. branch)
		branch = "-" .. branch
	else
		branch = ""
	end
	lists = cursor:get("updater", "pkglists", "lists")
	-- TODO this can also be for example yes but this should work in default
	datacollection_enabled = cursor:get("foris", "eula", "agreed_collect") == '1'
else
	ERROR("UCI library is not available. Not processing user lists.")
end

-- Verify contract
if not datacollection_enabled then
	local contract_valid = io.open('/usr/share/server-uplink/contract_valid', 'r')
	if not contract_valid then -- Try to generate it
		os.execute('/usr/share/server-uplink/contract_valid.sh')
		contract_valid = io.open('/usr/share/server-uplink/contract_valid', 'r')
	end
	if contract_valid then
		local contract_content = contract_valid:read()
		datacollection_enabled = contract_content == 'valid'
		contract_valid:close()
	else
		WARN("Contract wasn't verified")
		-- For Turris 1.x expect in default valid contract
		datacollection_enabled = model:match("^[Tt]urris$")
	end
end

-- Guess what board this is.
local base_model = ""
if model then
	if model:match("Turris Mox") then
		base_model = "mox"
	elseif model:match("[Oo]mnia") then
		base_model = "omnia"
	elseif model:match("[Tt]urris") then
		base_model = "turris"
	end
end

-- Definitions common url base
local base_url = "https://repo.turris.cz/" .. base_model .. branch .. "/lists/"
-- Reused options for remotely fetched scripts
local script_options = {
	security = "Remote",
	ca = system_cas,
	crl = no_crl,
	pubkey = {
		"file:///etc/updater/keys/release.pub",
		"file:///etc/updater/keys/standby.pub",
		"file:///etc/updater/keys/test.pub" -- It is normal for this one to not be present in production systems
	}
}

-- The distribution base script. It contains the repository and bunch of basic packages
Script("base",  base_url .. "base.lua", script_options)

-- Data collection list
if datacollection_enabled then
	Script("base",  base_url .. "i_agree_datacollect.lua", script_options)
end

-- Additional enabled distribution lists
if lists then
	if type(lists) == "string" then -- if there is single list then uci returns just a string
		lists = {lists}
	end
	-- Go through user lists and pull them in.
	local exec_list = {} -- We want to run userlist only once even if it's defined multiple times
	if type(lists) == "table" then
		for _, l in ipairs(lists) do
			if exec_list[l] then
				WARN("User list " .. l .. " specified multiple times")
			else
				Script("userlist-" .. l, base_url .. l .. ".lua", script_options)
				exec_list[l] = true
			end
		end
	end
end
