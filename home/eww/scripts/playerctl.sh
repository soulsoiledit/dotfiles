status=$(playerctl status)

if [ "$status" == "Playing" ]; then
	symbol='󰏥'
else
	symbol='󰐌'
fi

jq -n --arg status "$status" --arg symbol "$symbol" '{ status: $status, symbol: $symbol }'
