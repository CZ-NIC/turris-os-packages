TURRIS1X_STORAGE=/dev/mtdblock4

mount_store() {
	mount -t jffs2 -o compr=none "$TURRIS1X_STORAGE" "$1"
}
