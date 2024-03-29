volume() {
	# volume value & symbol
	volume=$(pamixer --get-volume)

	symbols=('󰕿' '󰖀' '󰕾')
	symbol=${symbols[(((10#$volume * 3 - 1) / 100))]}

	# mute status & symbol
	if [ "$(pamixer --get-mute)" == "true" ]; then
		mute='volume_muted'
		symbol='󰝟'
	else
		mute='volume_unmuted'
	fi

	jq -n -c --argjson volume "$volume" --arg mute "$mute" --arg symbol "$symbol" '{volume: $volume, mute: $mute, symbol: $symbol}'
}

volume
pactl subscribe | rg --line-buffered 'sink' | while read -r _; do
	volume
done
