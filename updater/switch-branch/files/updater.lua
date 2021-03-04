--[[
This file is part of switch-branch. Don't edit it.

This script includes test keys if target branch is not in known list of
stable branches.
This excludes mode == "version" as final versions are never signed by test key.
]]

-- Set of stable branches (signed by deploy or staging key)
local stable = {
	-- Stable (snails)
	["hbs"] = true,
	["🐌"] = true,
	-- Testing (turtles)
	["hbt"] = true,
	["🐢"] = true,
}


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
end
