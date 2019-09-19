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
    :
}

