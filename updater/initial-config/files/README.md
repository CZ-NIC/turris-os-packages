Initial system configuration
----------------------------
This package provides script that allows limited configuration of router after
factory reset or medkit reflash is used. The idea is to allow users to
preconfigure router in a way they can connect to it securely over Wi-Fi if
needed.

## Usage
User places configuration file to root directory of a flash drive. The name of
the file has to be: `medkit-config.json`. Such prepared flash drive is inserted to
router and factory reset or medkit reflash is performed. Flash drive has to be
kept in device till you access we interface.

Make sure to wipe configuration file from flash drive after that to not disclose
accidentally router's password when you reuse it. Other option is to change both
Foris and system password after initial setup.

## Configuration file format
Configuration file has to contain valid JSON.

### Example configuration
```
{
	"foris_password": "ForisPassword_ChangeThis!",
	"system_password": "SystemPassword_ChangeThis!",
	"wireless": {
		"ssid": "TurrisConfigWifi",
		"key": "WiFiPassword_ChangeThis!"
	}
}
```

### Foris Password
Option `foris_password` can be used to configure password for Foris web interface
and that way skip initial step in setup.

This is required to be used as web interfaces allows anyone to set initial
password. That makes router administration accessible by anyone. By setting
password even before Wi-Fi or/and Foris are started prevents access to just
everyone.

### System Password
Option `system_password` can be used to configure password for `root` account on
router. This is password used by LuCI web interfaces as well as SSH.

This is not essentially required on Turris, because in default root account is
blocked for interactive login. This is included rather for convenience for cases
when user wants to use SSH rather than Foris.

### Wireless AP configuration
Option `wireless` has to be set to object with `ssid` and `key` fields. It
configures first radio it can access on system to AP mode with provided SSID and
key (password).
