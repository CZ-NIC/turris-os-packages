#!/bin/sh

# Global defaults
BOARD=mox
DELAY=60
RESCUE_IF="`ip a s | sed -n 's|^[0-9]*:[[:blank:]]*\(lan0\)@.*|\1|p'`"
RESCUE_IF_UP="`ip a s | sed -n 's|^[0-9]*:[[:blank:]]*\(lan0\)@\([^:]*\):.*|\2|p'`"
WAN_IF="eth0"
HAVE_BTRFS=1
REPARTITION=1
MODE=1

# Include all helper functions

. /lib/helpers.sh
. /lib/board.sh

# Main loop

cmd_mode="$(sed -n 's|.*rescue_mode=\([0-9]\+\).*|\1|p' /proc/cmdline)"
[ -z "$cmd_mode" ] || MODE="$(expr $cmd_mode + 1)"
[ "$MODE" -le 7 ] || MODE=1
init
board_init
echo "Booting rescue mode for $BOARD in mode $MODE"
wait_for_mode_change
echo "Mode $MODE selected!"
busy
mode_"$MODE"
reboot
