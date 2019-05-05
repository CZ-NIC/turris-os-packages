-- TODO set this to hbs when final release is imminent
Script("https://repo.turris.cz/hbk/__BOARD__/lists/migrate3x.lua", {
	security = "Local",
	ca = system_cas,
	crl = no_crl,
	pubkey = {
		"file:///etc/updater/keys/release.pub",
		"file:///etc/updater/keys/standby.pub",
		"file:///etc/updater/keys/test.pub"
	}
})
