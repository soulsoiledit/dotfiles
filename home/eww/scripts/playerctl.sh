playerctl -F status | while read -r status; do
	if [ "$status" == "Playing" ]; then
		symbol='󰏥'
	else
		symbol='󰐌'
	fi

	jq -n -c --arg status "$status" --arg symbol "$symbol" '{ status: $status, symbol: $symbol }'
done
