acpi_output=$(acpi -b | rg -v 'unav')
state=$(echo "$acpi_output" | rg -o ': (.*?),' -r '$1')
percentage=$(echo "$acpi_output" | rg -o '(\d+)%' -r '$1')
remaining=$(echo "$acpi_output" | rg -o ' (\d+:\d+)' -r '$1')
wattage=$(cat /sys/class/power_supply/BAT0/power_now)

# TODO: add ramping symbols
if [ "$state" == "full" ] || [ "$state" == "Not charging" ]; then
	symbol="󰁹"
elif [ "$state" == "Discharging" ]; then
	symbol="󰁾"
elif [ "$state" == "Charging" ]; then
	symbol="󰂄"
fi

jq -n \
	--arg state "$state" \
	--arg perc "$percentage" \
	--arg remaining "$remaining" \
	--arg wattage "$wattage" \
	--arg symbol "$symbol" \
	'{state, $state, percentage: $perc, remaining: $remaining, wattage: $wattage, symbol: $symbol}'
