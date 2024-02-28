network() {
	status=''
	symbol=''

	if cat /sys/class/net/*/operstate | rg 'up' &>/dev/null; then
		status='network_up'
		symbol='󰖩'
	else
		status='network_down'
		symbol='󰖪'
	fi

	jq -n -c --arg status "$status" --arg symbol "$symbol" '{status: $status, symbol: $symbol}'
}

network
ip monitor link | rg --line-buffered 'state' | while read -r _; do
	network
done
