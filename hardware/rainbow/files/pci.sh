loadsrc led_activity

# In some cases we need to detect what is inserted in the specific PCI slot and
# setup activity trigger from system according to that. This function tries to
# do the detection produces activity configuration.
# It expects path to sysfs to the PCI device to investigate.
# This echoes activity argument for activity status.
# If no device was detected or if activity for it is not supported it signals
# failure with returned value.
pci_device_activity_detect() {
	local syspci="$1"
	local led="$1"

	if [ -d "$syspci/ieee80211" ]; then
		[ -n "$(supported_activities "$led" -xF 'netdev')" ] || return
		echo "netdev-$(ls -1 "$syspci/net" | head -1)"
		return
	fi

	for ata in "$syspci"/ata*; do
		[ -d "$ata" ] || continue
		[ -n "$(supported_activities "$led" -xF "$ata")" ] || continue
		echo "${ata##*/}"
		return
	done

	return 1
}
