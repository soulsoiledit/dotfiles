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
wattage=$(($power / 1000000))
wattage_dec=$(($power / 100000 % 100))

echo $percentage $remaining $wattage.${wattage_dec}W
