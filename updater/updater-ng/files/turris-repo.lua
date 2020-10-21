--[[
This file allows you to override path to Turris lists. Those are Lua scripts
maintained in default on https://repo.turris.cz along side the packages.
Sometimes you want to point all machinery to different server just for testing.
This file is here exactly for that.
]]
return {

	--[[
	Following line can be uncommented and changed to specify different server.
	]]
	--url = "https://repo.turris.cz",

	--[[
	Following few lines can be uncommented if you want to include your own public
	key used to sign your own copy of lists.
	This is used only if url is also defined.
	]]
	--pubkey = {
	--	"file:///etc/updater/keys/release.pub",
	--	"file:///etc/updater/keys/standby.pub",
	--	"file:///etc/updater/keys/test.pub"
	--},

	--[[
	These options are here rather for completeness. You can ping appropriate CA,
	specify CRL or disable OCSP.
	These options are ignored if url is not also defined.
	]]
	--ca = true,
	--crl = false,
	--ocsp = true,

}
