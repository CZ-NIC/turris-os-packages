if part uuid ${devtype} ${devnum}:${distro_bootpart} partuuid; then
	if test "${bootfstype}" = "btrfs"; then
		rootflags="commit=5,subvol=@"
		subvol="/@"
	else
		rootflags="commit=5"
		subvol=""
	fi

	if load ${devtype} ${devnum}:${distro_bootpart} ${fdt_addr_r} ${subvol}/boot/armada-3720-turris-mox.dtb; then
		has_dtb=1
	else
		setenv has_dtb 0
		echo "Cannot find device tree binary!"
	fi

	if test $has_dtb -eq 1; then
		if load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} ${subvol}/boot/Image; then
			setenv bootargs "earlyprintk console=ttyMV0,115200 earlycon=ar3700_uart,0xd0012000 rootfstype=${bootfstype} root=PARTUUID=${partuuid} rootflags=${rootflags} rootwait ${contract} rw cfg80211.freg=${regdomain}"
			booti ${kernel_addr_r} - ${fdt_addr_r}
			echo "Booting Image failed"
		else
			echo "Cannot load kernel binary"
		fi
	fi

	env delete partuuid
fi
