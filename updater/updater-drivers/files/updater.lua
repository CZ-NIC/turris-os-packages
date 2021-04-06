--[[
This file is part of package updater-drivers. Don't edit it.
]]

if root_dir ~= "/" then
	WARN("Additional drivers not included as detection is possible only on current root")
	return
end

local function cat_file(path)
	local f, err = io.open(path)
	if not f then
		TRACE("cat_file failed for: " .. path .. ": " .. err)
		return nil
	end
	local content = f:read()
	f:close()
	return content
end

-- Some duplicate code from updater-ng package to get base_url
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

local mode = uci_cnf("mode", "branch") -- should we follow branch or version?
local branch = uci_cnf("branch", "hbs") -- which branch to follow
local version = uci_cnf("version", nil) -- which version to follow
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
	base_url = "https://repo.turris.cz/" .. branch .. "/" .. board .. "/lists/"
elseif mode == "version" then
	base_url = "https://repo.turris.cz/archive/" .. version .. "/" .. board .. "/lists/"
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

local function turris_list(path)
	Script(base_url .. path, script_options)
end
----------------------------------------------------------------------------------
devices = {}
Export("devices")

-- USB
devices = {}
for name, _ in pairs(ls("/sys/bus/usb/devices")) do
	local vendor = cat_file("/sys/bus/usb/devices/" .. name .. "/idVendor")
	local product = cat_file("/sys/bus/usb/devices/" .. name .. "/idProduct")
	if vendor and product then
		table.insert(devices, {
			vendor = tonumber("0x" .. vendor),
			product = tonumber("0x" .. product)
		})
	end
end
turris_list("drivers/usb.lua")


-- PCI
devices = {}
for name, _ in pairs(ls("/sys/bus/pci/devices")) do
	local vendor = cat_file("/sys/bus/pci/devices/" .. name .. "/vendor")
	local device = cat_file("/sys/bus/pci/devices/" .. name .. "/device")
	if vendor and device then
		table.insert(devices, {
			vendor = tonumber(vendor),
			device = tonumber(product)
		})
	end
end
turris_list("drivers/pci.lua")
