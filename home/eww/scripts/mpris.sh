function status() {
	playerctl -p "playerctld" -F status | while read -r status; do
		if [ "$status" == "Playing" ]; then
			symbol='󰏥'
		else
			symbol='󰐌'
		fi

		jq -n -c --arg status "$status" --arg symbol "$symbol" '{ status: $status, symbol: $symbol}'
	done
}

function metadata() {
	playerctl -p "playerctld" -F metadata --format '{"artist": "{{ artist }}", "album": "{{ album }}", "title": "{{ title }}"}' | while read -r metadata; do
		echo "$metadata" | jq -c
	done
}

case "$1" in
"status") status ;;
"metadata") metadata ;;
esac
