brightness() {
	# brightness percentage
	brightness=$(brightnessctl info | rg -o '(\d+)%' -r '$1')

	# brightness level
	symbols=('󰽤' '' '' '' '' '󰃠')
	symbol=${symbols[(((10#$brightness * 6 - 1) / 100))]}

	jq -n -c --arg symbol "$symbol" '{symbol: $symbol}'
}

brightness
while inotifywait -e close_write /sys/class/backlight/*/brightness &>/dev/null; do brightness; done
