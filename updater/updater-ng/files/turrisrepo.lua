--[[
This file is part of updater-ng. Don't edit it.
]]

local Repo = {}
Repo.__index = Repo


local uci_cursor = nil
if uci then
	uci_cursor = uci.cursor(root_dir .. "/etc/config")
else
	ERROR("UCI library is not available. Configuration not used.")
end
local function uci_cnf(name, default)
	if uci_cursor then
		return uci_cursor:get("updater", "turris", name) or default
	else
		return default
	end
end

-- Configuration variables
Repo.mode = uci_cnf("mode", "branch") -- should we follow branch or version?
Repo.branch = uci_cnf("branch", "hbs") -- which branch to follow
Repo.version = uci_cnf("version", nil) -- which version to follow
-- Verify that we have sensible configuration
if Repo.mode == "version" and not version then
	WARN("Mode configured to be 'version' but no version provided. Changing mode to 'branch' instead.")
	Repo.mode = "branch"
end


-- Detect host board
local product = os_release["OPENWRT_DEVICE_PRODUCT"] or os_release["LEDE_DEVICE_PRODUCT"]
if product:match("[Mm]ox") then
	Repo.board = "mox"
elseif product:match("[Oo]mnia") then
	Repo.board = "omnia"
elseif product:match("[Tt]urris 1.x") then
	Repo.board = "turris1x"
else
	DIE("Unsupported Turris board: " .. tostring(product))
end


-- Common URI to Turris OS lists
if Repo.mode == "branch" then
	Repo.base_url = "https://repo.turris.cz/" .. Repo.branch .. "/" .. Repo.board .. "/lists/"
elseif Repo.mode == "version" then
	Repo.base_url = "https://repo.turris.cz/archive/" .. Repo.version .. "/" .. Repo.board .. "/lists/"
else
	DIE("Invalid updater.turris.mode specified: " .. Repo.mode)
end


return Repo
