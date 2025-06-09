id=0
upower -m /org/freedesktop/UPower/device/battery_BAT$id | while
  if [[ $(acpi -b) =~ Battery.$id:.([[:alpha:]]*),.([[:digit:]]*)%,.([[:digit:]:]*) ]]; then
    status=${BASH_REMATCH[1]}
    percentage=${BASH_REMATCH[2]}
    time_remaining=${BASH_REMATCH[3]}
  fi

  rate=$(</sys/class/power_supply/BAT$id/power_now)

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
    --arg status "$status" \
    --argjson percentage "$percentage" \
    --arg time_remaining "$time_remaining" \
    --argjson rate "$rate" \
    --arg symbol "$symbol" \
    '{status, $status, percentage: $percentage, time_remaining: $time_remaining, rate: $rate, symbol: $symbol}'

  read -r _
do continue; done
