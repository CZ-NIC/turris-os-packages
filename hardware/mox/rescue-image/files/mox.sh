#!/bin/sh

. /lib/board_helpers.sh

handle_reset() {
    while sleep 0.2; do
        pressed=0
        while [ "$(cat /sys/class/gpio/gpio466/value)" -eq 0 ]; do
            sleep 0.1
            pressed="$(expr "$pressed" + 1)"
            [ "$pressed" -gt 20 ] || continue
            echo "Rebooting as requested!"
            reboot
        done
    done
}

board_init() {
    generic_pre_init
    echo 466 > /sys/class/gpio/export
    echo in > /sys/class/gpio/gpio466/direction
    echo default-on > /sys/class/leds/red/trigger
    mkdir -p /etc
    echo '/dev/mtd2 0 0x00010000' > /etc/fw_env.config
    BUTTON_STATE="$(cat /sys/class/gpio/gpio466/value)"
    TARGET_DRIVE="/dev/mmcblk1"
    TARGET_PART="1"
    [ -n "$RESCUE_IF" ] || RESCUE_IF=eth0
    handle_reset &
    generic_post_init
}

check_for_mode_change() {
    new_btn_state="$(cat /sys/class/gpio/gpio466/value)"
    chk_ret=1
    if [ "$new_btn_state" -eq 0 ] && [ "$new_btn_state" -ne "$BUTTON_STATE" ]; then
        chk_ret=0
    fi
    BUTTON_STATE="$new_btn_state"
    return $chk_ret
}

display_mode() {
    echo none > /sys/class/leds/red/trigger
    sleep 0.5
    for i in $(seq 1 "$MODE"); do
        sleep 0.2
        echo default-on > /sys/class/leds/red/trigger
        sleep 0.2
        echo none > /sys/class/leds/red/trigger
    done
    sleep 0.5
    echo default-on > /sys/class/leds/red/trigger
}

busy() {
    echo timer > /sys/class/leds/red/trigger
    while sleep 0.5; do [ "$(cat /sys/class/gpio/gpio466/value)" -eq 1 ] || reboot; done &
}

die() {
    predie "$1" "$2"
    while sleep 0.5; do
        sleep 0.3
        for i in $(seq 1 "$ret_code"); do
            sleep 0.2
            echo default-on > /sys/class/leds/red/trigger
            sleep 0.2
            echo none > /sys/class/leds/red/trigger
        done
        sleep 1.5
    done
}

