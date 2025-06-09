# TODO: add kbd brightness monitoring
udevadm monitor -u | while read -r line; do
  if ! [[ $line =~ backlight ]]; then
    continue
  fi

  brightness=$(brightnessctl info -m)

  if [[ $brightness =~ ([[:digit:]]*)% ]]; then
    perc=${BASH_REMATCH[1]}

    symbols=('󰽤' '' '' '' '' '󰃠')
    symbol=${symbols[((($perc * 6 - 1) / 100))]}

    notify-send "$symbol  $perc%" -h int:value:"$perc" -h string:x-canonical-private-synchronous:brightness
    jq -n -c --arg symbol "$symbol" '{symbol: $symbol}'
  fi
done
