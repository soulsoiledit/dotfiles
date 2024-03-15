battery() {
	acpi_output=$(acpi -b | rg -v 'unav')
	state=$(echo "$acpi_output" | rg -o ': (.*?),' -r '$1')
	percentage=$(echo "$acpi_output" | rg -o '(\d+)%' -r '$1')
	remaining=$(echo "$acpi_output" | rg -o ' (\d+:\d+)' -r '$1')
	wattage=$(cat /sys/class/power_supply/BAT0/power_now)

	if [ "$state" == "Full" ] || [ "$state" == "Not charging" ]; then
		symbol="󰁹"
	elif [ "$state" == "Discharging" ]; then
		symbols=('󰂎' '󱊡' '󱊢' '󱊣')
		symbol=${symbols[(((10#$percentage * 4 - 1) / 100))]}
	elif [ "$state" == "Charging" ]; then
		symbols=('󰢟' '󱊤' '󱊥' '󱊦')
		symbol=${symbols[(((10#$percentage * 4 - 1) / 100))]}
	fi

	jq -n -c \
		--arg state "$state" \
		--arg perc "$percentage" \
		--arg remaining "$remaining" \
		--arg wattage "$wattage" \
		--arg symbol "$symbol" \
		'{state, $state, percentage: $perc, remaining: $remaining, wattage: $wattage, symbol: $symbol}'
}

battery
upower -m | rg --line-buffered 'battery_BAT.' | while read -r _; do
	battery
done
