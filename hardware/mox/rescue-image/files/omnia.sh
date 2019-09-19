#!/bin/sh

. /lib/board_helpers.sh

board_init() {
    generic_pre_init
    # Default mode on Omnia is serial
    MODE=7
    mkdir -p /etc
    echo '/dev/mtd0 0xF0000 0x10000 0x10000' > /etc/fw_env.config
    TARGET_DRIVE="/dev/mmcblk0"
    TARGET_PART="${TARGET_DRIVE}p1"
    BRIGHT="`cat /sys/class/leds/omnia-led\:all/device/global_brightness`"
    WAN_IF="eth2"
    DELAY=40
    RESCUE_IF="`ip a s | sed -n 's|^[0-9]*:[[:blank:]]*\(lan4\)@.*|\1|p'`"
    RESCUE_IF_UP="`ip a s | sed -n 's|^[0-9]*:[[:blank:]]*\(lan4\)@\([^:]*\):.*|\2|p'`"
    echo '0 255 0' >  /sys/class/leds/omnia-led\:all/color
    echo default-on > /sys/class/leds/omnia-led\:all/trigger
    enable_btrfs
    generic_post_init
}

check_for_mode_change() {
    if [ "`cat /sys/class/leds/omnia-led\:all/device/global_brightness`" -ne "$BRIGHT" ]; then
        echo "$BRIGHT" > /sys/class/leds/omnia-led\:all/device/global_brightness
        return 0
    fi
    return 1
}

display_mode() {
    MODE_TG=default-on
    echo '255 64 0' >  /sys/class/leds/omnia-led\:all/color
    for i in /sys/class/leds/omnia-led*; do
        echo none > "$i"/trigger
    done
    echo "$MODE_TG" > /sys/class/leds/omnia-led\:power/trigger
    if [ "$MODE" -gt 1 ]; then
        echo "$MODE_TG" > /sys/class/leds/omnia-led\:lan0/trigger
    fi
    if [ "$MODE" -gt 2 ]; then
        echo "$MODE_TG" > /sys/class/leds/omnia-led\:lan1/trigger
    fi
    if [ "$MODE" -gt 3 ]; then
        echo "$MODE_TG" > /sys/class/leds/omnia-led\:lan2/trigger
    fi
    if [ "$MODE" -gt 4 ]; then
        echo "$MODE_TG" > /sys/class/leds/omnia-led\:lan3/trigger
    fi
    if [ "$MODE" -gt 5 ]; then
        echo "$MODE_TG" > /sys/class/leds/omnia-led\:lan4/trigger
    fi
    if [ "$MODE" -gt 6 ]; then
        echo "$MODE_TG" > /sys/class/leds/omnia-led\:wan/trigger
    fi
    if [ "$MODE" -gt 7 ]; then
        echo "$MODE_TG" > /sys/class/leds/omnia-led\:pci1/trigger
    fi
    if [ "$MODE" -gt 8 ]; then
        echo "$MODE_TG" > /sys/class/leds/omnia-led\:pci2/trigger
    fi
    if [ "$MODE" -gt 9 ]; then
        echo "$MODE_TG" > /sys/class/leds/omnia-led\:pci3/trigger
    fi
}

busy() {
    echo '255 0 0' >  /sys/class/leds/omnia-led\:all/color
}

die() {
    predie "$1" "$2"
    echo '0 0 255' >  /sys/class/leds/omnia-led\:all/color
    echo timer > /sys/class/leds/omnia-led\:all/trigger
    while true; do
        sleep 1
    done
}

