HOSTNAME="${COLLECTD_HOSTNAME:-localhost}"
INTERVAL="${COLLECTD_INTERVAL:-60}"

VALUE="$(ip n | wc -l)"
echo "PUTVAL \"$HOSTNAME/exec-neighbours/gauge-neighbours\" interval=$INTERVAL N:$VALUE"
