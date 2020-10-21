--[[
This file is part of updater-ng. Don't edit it.
]]

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
local mode = uci_cnf("mode", "branch") -- should we follow branch or version?
local branch = uci_cnf("branch", "hbs") -- which branch to follow
local version = uci_cnf("version", nil) -- which version to follow

-- Verify that we have sensible configuration
if mode == "version" and not version then
	WARN("Mode configured to be 'version' but no version provided. Changing mode to 'branch' instead.")
	mode = "branch"
end

-- Detect host board
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

-- Common connection settings for Turris OS scripts
local script_options = {
	security = "Remote",
	pubkey = {
		"file:///etc/updater/keys/release.pub",
		"file:///etc/updater/keys/standby.pub",
		"file:///etc/updater/keys/test.pub" -- It is normal for this one to not be present in production systems
	}
}

-- Turris repository server URL (or override)
local repo_url = "https://repo.turris.cz"
local config, config_error = loadfile("/etc/updater/turris-repo.lua")
if config then
	config = config()
	if config.url ~= nil then
		repo_url = config.url
		for _, field in {"pubkey", "ca", "crl", "ocsp"} do
			if config[field] ~= nil then
				script_options[field] = config[field]
			end
		end
	end
else
	WARN("Failed to load /etc/updater/turris-repo.lua: " .. tostring(config_error))
end

-- Common URI to Turris OS lists
local base_url
if mode == "branch" then
	base_url = repo_url .. "/" .. branch .. "/" .. board .. "/lists/"
elseif mode == "version" then
	base_url = repo_url .. "/archive/" .. version .. "/" .. board .. "/lists/"
else
	DIE("Invalid updater.turris.mode specified: " .. mode)
end

-- The distribution base script. It contains the repository and bunch of basic packages
Script(base_url .. "base.lua", script_options)

-- Additional enabled distribution lists forced by boot arguments
if root_dir == "/" then
	local cmdf = io.open("/proc/cmdline")
	if cmdf then
		for cmdarg in cmdf:read():gmatch('[^ ]+') do
			local key, value = cmdarg:match('([^=]+)=(.*)')
			if key == "turris_lists" then
				for list in value:gmatch('[^,]+') do
					Script(base_url .. list .. ".lua", script_options)
				end
			end
		end
		cmdf:close()
	end
end
