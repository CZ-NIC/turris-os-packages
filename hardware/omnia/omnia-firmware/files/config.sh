UBOOT_PART="mtd0"
RESCUE_PART="mtd1"
UBOOT_DEVEL="/usr/share/omnia/uboot-devel"

have_old_uboot() {
    if fw_printenv -c /usr/share/nor-update/old-uboot.config 2>&1 | grep -q 'Bad CRC, using default environment'; then
        return 0
    else
        return 1
    fi
}

board_pre_hook() {
    UPDATE_UENV=""
    have_old_uboot || return 0
    v_echo "Storing old U-boot environment to be preserved"
    UPDATE_UENV="/usr/share/nor-update/uenv.backup"
    [ \! -e "$UPDATE_UENV" ] || die "You already have a backup of U-Boot environment in $UPDATE_UENV, clean it up first!"
    fw_printenv -c /usr/share/nor-update/old-fwenv.config 2>&1 > "$UPDATE_UENV"
    # Replace deprecated btrload command with load, see comment bellow
    #         btrload               mmc                        0                          0x02000000                     boot/dtb                       @               => load mmc 0 0x02000000 @/boot/dtb
    sed -i 's|btr\(load[[:blank:]]\+[^[:blank:]]\+[[:blank:]]\+[^[:blank:]]\+[[:blank:]]\+[^[:blank:]]\+[[:blank:]]\+\)\([^[:blank:]]\+\)[[:blank:]]\+\([^[:blank:];]\+\)|\1\3/\2|g' "$UPDATE_UENV"
}

board_post_hook() {
    if [ "$UPDATE_UENV" ]; then
        if fw_setenv -c /usr/share/nor-update/new-fwenv.config -s "$UPDATE_UENV"; then
            echo "Your U-Boot environment was migrated to new U-Boot"
            echo "You can find it in $UPDATE_UENV"
            echo "You can reset it via 'fw_setenv bootcmd \"env default -f -a; saveenv; reset\"'"
        else
            echo "Migration of your U-Boot environment failed."
            echo "You can find it in $UPDATE_UENV"
            echo "Set whatever you need manually via 'fw_setenv'"
        fi
    fi
}
