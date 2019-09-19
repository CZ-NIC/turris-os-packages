#!/bin/sh

# Generic functions used by board specific ones

predie() {
        ret_code="$1"
        shift
        if [ -f /tmp/debug.txt ]; then
            echo "Debug info:"
            cat /tmp/debug.txt
        fi
        echo "$1"
        setsid cttyhack sh &
}

generic_pre_init() {
    :
}

generic_post_init() {
    if [ -n "$HAVE_BTRFS" ]; then
        mkdir -p /etc/schnapps
        echo "ROOT_DEV='${TARGET_DRIVE}p${TARGET_PART}'" > /etc/schnapps/config
        MODE1_NEXT=2
    else
        MODE1_NEXT=4
    fi
}

