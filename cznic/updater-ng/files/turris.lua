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
local lists = uci_cnf("pkglists", {}) -- what additional lists should we use
minimal_builds = uci_cnf("use_minimal", false) -- if packages-minimal should be used
Export('minimal_builds')

-- Verify that we have sensible configuration
if type(lists) == "string" then -- if there is single list then uci returns just a string
	lists = {lists}
end
if mode == "version" and not version then
	WARN("Mode configured to be 'version' but no version provided. Changing mode to 'branch' instead.")
	mode = "branch"
end

-- Common URL base to Turris OS repository
if mode == "branch" then
	repo_base_uri = "https://repo.turris.cz/" .. branch
elseif mode == "version" then
	repo_base_uri = "https://repo.turris.cz/archive/" .. version
else
	DIE("Invalid updater.turris.mode specified: " .. mode)
end
Export('repo_base_uri')

-- Common connection settings for Turris OS scripts
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

local base_url = repo_base_uri .. "/lists/"
-- The distribution base script. It contains the repository and bunch of basic packages
Script(base_url .. "base.lua", script_options)

-- Additional enabled distribution lists
local exec_list = {} -- We want to run userlist only once even if it's defined multiple times
for _, l in ipairs(lists) do
	if exec_list[l] then
		WARN("Turris package list '" .. l .. "' specified multiple times")
	else
		Script(base_url .. l .. ".lua", script_options)
		exec_list[l] = true
	end
end
