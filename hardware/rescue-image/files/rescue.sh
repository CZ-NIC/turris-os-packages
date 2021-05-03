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

. /lib/board.sh
. /lib/helpers.sh

# Main loop

init
board_init
fetch_cmd_mode
echo "Booting rescue mode for $BOARD in mode $MODE"
wait_for_mode_change
echo "Mode $MODE selected!"
busy
override_root # Some alternative roots might take a while to initialize
haveged -F & # Provide some extra entropy
mode_"$MODE"
echo "Everything done, rebooting!"
reboot
