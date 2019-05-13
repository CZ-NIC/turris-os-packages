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
local pkglists = uci_cnf("pkglists", {}) -- what additional lists should we use

-- Verify that we have sensible configuration
if mode == "version" and not version then
	WARN("Mode configured to be 'version' but no version provided. Changing mode to 'branch' instead.")
	mode = "branch"
end

-- Convert pkglists to set set of lists (ensures uniqueness)
if type(pkglists) == "string" then -- if there is single list then uci returns just a string
	pkglists = {pkglists}
end
local lists = {}
for list in pairs(pkglists) do
	lists["pkglists/" .. list] = true
end

-- Load lists forced by boot arguments
if root_dir == "/" then
	local cmdf = io.open("/proc/cmdline")
	if cmdf then
		for cmdarg in cmdf:read():gmatch('[^ ]+') do
			local key, value = cmdarg:match('([^=]+)=(.*)')
			if key == "turris_lists" then
				for list in value:gmatch('[^,]+') do
					lists[list] = true
				end
			end
		end
		cmdf:close()
	end
end

-- Detect host board
local product = os_release["LEDE_DEVICE_PRODUCT"]
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

-- Common URI to Turris OS lists
local base_url
if mode == "branch" then
	base_url = "https://repo.turris.cz/" .. branch .. "/" .. board .. "/lists/"
elseif mode == "version" then
	base_url = "https://repo.turris.cz/archive/" .. version .. "/" .. board .. "/lists/"
else
	DIE("Invalid updater.turris.mode specified: " .. mode)
end

-- Common connection settings for Turris OS scripts
local script_options = {
	security = "Remote",
	pubkey = {
		"file:///etc/updater/keys/release.pub",
		"file:///etc/updater/keys/standby.pub",
		"file:///etc/updater/keys/test.pub" -- It is normal for this one to not be present in production systems
	}
}

-- The distribution base script. It contains the repository and bunch of basic packages
Script(base_url .. "base.lua", script_options)

-- Additional enabled distribution lists
for l in pairs(lists) do
	Script(base_url .. l .. ".lua", script_options)
end
