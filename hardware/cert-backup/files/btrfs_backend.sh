SUBVOLUME=certbackup

mount_store() (
	local workdir="$1"
	local root="/"
	# Note: --pairs ensures safety of this eval
	eval "$(findmnt --first-only --uniq --pairs --output SOURCE,FSTYPE "$root")"
	[ "$FSTYPE" = "btrfs" ] || {
		echo "cert-backup is available only on Btrfs root filesystem" >&2
		exit 2
	}

	# Source in case of BTRFS contains subvolume at the end in square brackets
	local partition="${SOURCE%%\[*\]}"
	if ! btrfs subvolume list -a "$root" | grep -q "path <FS_TREE>/$SUBVOLUME$"; then
		# Create subvolume if it missing
		mount -t btrfs -o subvol=/ "$partition" "$workdir"
		btrfs subvolume create "$workdir/$SUBVOLUME"
		umount "$workdir"
	fi
	mount -t btrfs -o subvol="/$SUBVOLUME" "$partition" "$workdir"
)
