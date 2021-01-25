UBOOT_PART="mtd0"
RESCUE_PART="mtd1"
UBOOT_DEVEL="/usr/share/omnia/uboot-devel"

have_new_uboot() {
    return fw_printenv -c /usr/share/nor-update/old-uboot.config 2>&1 | grep -q 'Bad CRC, using default environment'
}

board_pre_hook() {
    if ! have_new_uboot; then
        v_echo "Storing old U-boot environment to be preserved"
        UPDATE_UENV="$(/usr/share/omnia/uenv.backup)"
        fw_printenv -c /usr/share/nor-update/old-fwenv.config 2>&1 > "$UPDATE_UENV"
    else
        UPDATE_UENV=""
    fi
}

board_post_hook() {
    if [ "$UPDATE_UENV" ]; then
        if fw_setenv -s -c /usr/share/nor-update/new-fwenv.config < "$UPDATE_UENV"; then
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
