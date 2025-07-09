# takes battery id as first argument
id="$1"
upower -m /org/freedesktop/UPower/device/battery_BAT"$id" | while read -r _; do
  # parse acpi output
  if [[ $(acpi -b) =~ Battery.$id:.([[:alpha:]]*),.([[:digit:]]*)%,.([[:digit:]:]*) ]]; then
    status=${BASH_REMATCH[1]}
    percentage=${BASH_REMATCH[2]}
    time_remaining=${BASH_REMATCH[3]}
  fi

  rate=$(</sys/class/power_supply/BAT"$id"/power_now)

  if [[ $percentage -ge 98 ]]; then
    symbol="󰁹"
  else
    if [[ $status == "Charging" ]]; then
      symbols=("󰢟" "󱊤" "󱊥" "󱊦")
    elif [[ $status == "Discharging" ]]; then
      symbols=("󰂎" "󱊡" "󱊢" "󱊣")
    fi

    symbol=${symbols[(((percentage * 4 - 1) / 100))]}
  fi

  jq -n -c \
    --arg symbol "$symbol" \
    --argjson percentage "$percentage" \
    --arg status "$status" \
    --arg time_remaining "$time_remaining" \
    --argjson rate "$rate" \
    '{symbol, $symbol, percentage: $percentage, status: $status, time_remaining: $time_remaining, rate: $rate}'
done
