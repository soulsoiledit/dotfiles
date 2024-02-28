status=''
symbol=''

if ping -c 1 8.8.8.8 &>/dev/null; then
	status='network_up'
	symbol='󰖩'
else
	status='network_down'
	symbol='󰖪'
fi

jq -n --arg status "$status" --arg symbol "$symbol" '{status: $status, symbol: $symbol}'
