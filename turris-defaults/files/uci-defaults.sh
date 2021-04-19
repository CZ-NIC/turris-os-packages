if ! uci -q get 'system.@system[-1].zonename'; then
	uci set 'system.@system[-1].zonename=Europe/Prague'
fi

if ! uci -q get 'system.@system[-1]._country'; then
	uci set 'system.@system[-1]._country=CZ'
fi

if [ -n "$(uci change 'system.@system[-1]')" ]; then
	uci commit 'system.@system[-1]'
fi
