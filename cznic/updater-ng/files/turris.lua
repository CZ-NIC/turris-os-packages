--[[
This file is part of updater-ng. Don't edit it.
]]

local branch = "hbs"
local lists
local datacollection_enabled = false
if uci then
	local cursor = uci.cursor()
	uci_branch = cursor:get("updater", "override", "branch")
	if uci_branch then
		WARN("Branch overriden to " .. uci_branch)
		branch = uci_branch
	end
	lists = cursor:get("updater", "pkglists", "lists")
	-- TODO this can also be for example yes but this should work in default
	datacollection_enabled = cursor:get("foris", "eula", "agreed_collect") == '1'
else
	ERROR("UCI library is not available. Configuration not used.")
end

-- TODO Turris 1.x contract? Or should we drop it.

-- Definitions common url base
local base_url = "https://repo.turris.cz/" .. branch .. "/lists/"
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

