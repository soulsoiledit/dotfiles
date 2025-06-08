# TODO: add kbd brightness monitoring
udevadm monitor -u | rg --line-buffered backlight | while
  out=$(brightnessctl info -m)

  if [[ "$out" =~ ([0-9]*)\% ]]; then
    perc=$((10#${BASH_REMATCH[1]}))

    symbols=('󰽤' '' '' '' '' '󰃠')
    symbol=${symbols[((($perc * 6 - 1) / 100))]}

    notify-send "$symbol  $perc%" -h int:value:"$perc" -h string:x-canonical-private-synchronous:brightness
    jq -n -c --arg symbol "$symbol" '{symbol: $symbol}'
  fi

  read -r _
do
  true
done
