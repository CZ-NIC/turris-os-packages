UBOOT_PART="mtd0"
RESCUE_PART="mtd1"
UBOOT_DEVEL="/usr/share/omnia/uboot-devel"

board_ubootenv_hook() {
    sed -i 's|btr\(load[[:blank:]]\+[^[:blank:]]\+[[:blank:]]\+[^[:blank:]]\+[[:blank:]]\+[^[:blank:]]\+[[:blank:]]\+\)\([^[:blank:]]\+\)[[:blank:]]\+\([^[:blank:];]\+\)|\1\3/\2|g' \
        "$BACKUP_UBOOT_ENV"
}
