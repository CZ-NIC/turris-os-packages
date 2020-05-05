--[[
This file is part of switch-branch. Don't edit it.

This script includes test keys if target branch is not in known list of
stable branches.
This excludes mode == "version" as final versions are never signed by test key.

This script also servers as guard that trigger reinstall of all packages when
switch between unstable branches was performed. This is because such branches are
not binary compatible and can provide packages of same version and such packages
would not be reinstalled otherwise.
]]

local default_branch = "hbs"
local swb_dir = root_dir .. "/usr/share/updater/switch-branch"
local swb_state = swb_dir .. "/state"
local swb_reinstall_guard = swb_dir .. "/reinstall-guard"

-- Set of stable branches (signed by deploy or staging key)
local stable = {
	-- Stable (snails)
	["hbs"] = true,
	["🐌"] = true,
	-- Testing (turtles)
	["hbt"] = true,
	["🐢"] = true,
}

-- Set of branches we can safely switch between (binary compatible)
local safe_switch = {
	unpack(stable),
	-- Kittens
	["hbk"] = true,
	["🐈"] = true,
}


--[[
General function to store/write branch to state file
]]
local function write_state(state)
	local file, err_str = io.open(swb_state, "w")
	if not file then
		ERROR("Failed to write state for branch switch: " .. err_str)
		return
	end
	file:write(state)
	file:close()
end

--[[
General function to protectly read previous branch.
]]
local function read_state()
	local file, err_str = io.open(swb_state)
	if not file then
		DBG("Failed to read switch-branch state: " .. err_str)
		--[[
		It is missing (possibly). That means we are running for the first time
		(possibly). In such case we consider default branch as correct one.
		]]
		write_state(default_branch)
		return default_branch
	end
	local state = file:read()
	file:close()
	return state
end

--[[
Sets reinstall guard and that way ensures that reinstall is going to be proceeded.
]]
local function reinstall_guard_set()
	local file, err_str = io.open(swb_reinstall_guard, "w")
	if not file then
		ERROR("Failed to set reinstall guard for switch-branch: " .. err_str)
		return
	end
	file:write("reinstall")
	file:close()
end

--[[
Check state of reinstall guard.
Returns true if guard is set and false if it is in default state.
]]
local function reinstall_guard_state()
	local file, err_str = io.open(swb_reinstall_guard)
	if not file then
		ERROR("Can't read reinstall flag, considering tainted and requesting reinstall: " .. err_str)
		return true
	end
	local state = file:read()
	file:close()
	return state == "reinstall"
end

----------------------------------------------------------------------------------

if uci then -- We need UCI for this
	local uci_cursor = uci.cursor(root_dir .. "/etc/config")

	-- Install test keys for test branches
	local mode = uci_cursor:get("updater", "turris", "mode")
	if not mode or mode == "branch" then
		local branch = uci_cursor:get("updater", "turris", "branch")
		if branch and not stable[branch] then
			Install("cznic-repo-keys-test", { priority = 40 })
		end
	end

	-- Check for branch switch
	local branch = default_branch
	if not mode or mode == "branch" then
		local branch = uci_cursor:get("updater", "turris", "branch")
	end

	-- Get stored original branch
	local orig_branch = read_state()

	--[[
	If branch switch is detected and either current or target branch is not
	considered safe to switch then reinstall is requested.
	We always update state to target branch if they are not the same.
	]]
	if orig_branch ~= branch then
		if (not safe_switch[orig_branch] or not safe_switch[branch]) then
			reinstall_guard_set()
		end
		write_state(branch)
	end

	-- In general if reinstall guard is set we want to request reinstall
	if reinstall_guard_state() then
		Mode("reinstall-all")
	end
end
