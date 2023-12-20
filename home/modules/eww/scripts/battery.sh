acpi_output=$(acpi -b | grep -vP 'unav')

regex="([0-9]+%)"
if [[ $acpi_output =~ $regex ]]; then
	percentage="${BASH_REMATCH[1]}"
fi

regex="([0-9]+:[0-9]+:[0-9]+)"
if [[ $acpi_output =~ $regex ]]; then
	remaining="${BASH_REMATCH[1]}"
fi

power=$(cat /sys/class/power_supply/BAT0/power_now)

jq --null-input \
	--arg perc $percentage \
	--arg remaining "$remaining" \
	--arg power $power \
	'{"percentage": $perc, "remaining": $remaining, "power": $power}'
