# takes battery id as first argument
id="${1:-0}"
upower -m /org/freedesktop/UPower/device/battery_BAT"$id" | while read -r _; do
  battery_path="/sys/class/power_supply/BAT$id"

  [[ -d $battery_path ]] || continue

  status=$(<"$battery_path/status")
  percentage=$(<"$battery_path/capacity")
  power=$(<"$battery_path/power_now")
  energy=$(<"$battery_path/energy_now")
  energy_full=$(<"$battery_path/energy_full")

  if ((power > 0)); then
    if [[ $status == "Charging" ]]; then
      # get remaining to calculate time to full
      left=$((energy_full - energy))
      hours=$((left / power))
      minutes=$(((left * 60 / power) % 60))
    else
      # calculate time to empty
      hours=$((energy / power))
      minutes=$(((energy * 60 / power) % 60))
    fi
    printf -v time_remaining "%dh %02dm" $hours $minutes
  elif [[ $status == "Full" ]]; then
    time_remaining="Full"
  else
    time_remaining="Unknown"
  fi

  # pick symbol set
  if [[ $status == "Charging" ]]; then
    symbols=("󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂄")
  elif [[ $status == "Discharging" ]]; then
    symbols=("󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
  fi

  symbol=${symbols[((percentage * 10 / 98))]}

  jq -n -c \
    --arg symbol "$symbol" \
    --argjson percentage "$percentage" \
    --arg status "$status" \
    --arg time_remaining "$time_remaining" \
    --argjson rate "$power" \
    '{$symbol, $percentage, $status, $time_remaining, $rate}'
done
