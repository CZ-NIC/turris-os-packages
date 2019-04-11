Script("https://repo.turris.cz/hbd/lists/migrate3x.lua", {
	security = "Local",
	ca = system_cas,
	crl = no_crl,
	pubkey = {
		"file:///etc/updater/keys/release.pub",
		"file:///etc/updater/keys/standby.pub",
		"file:///etc/updater/keys/test.pub"
	}
})
