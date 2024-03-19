brightness() {
	# brightness percentage
	brightness=$(brightnessctl info | rg -o '(\d+)%' -r '$1')

	# brightness level
	symbols=('󰽤' '' '' '' '' '󰃠')
	symbol=${symbols[(((10#$brightness * 6 - 1) / 100))]}

	jq -n -c --arg symbol "$symbol" '{symbol: $symbol}'
}

brightness
udevadm monitor -u | rg --line-buffered "backlight" | while read -r _; do
	brightness
done
