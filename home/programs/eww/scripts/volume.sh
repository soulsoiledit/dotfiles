pw-mon -o -a | rg -s --line-buffered 'Node' | while
  # volume value & symbol
  volume=$(pamixer --get-volume)

  symbols=('' '' '')
  symbol=${symbols[(((10#$volume * 3 - 1) / 100))]}

  # mute status & symbol
  if [ "$(pamixer --get-mute)" == "true" ]; then
    mute='volume-muted'
    symbol=''
  else
    mute='volume-unmuted'
  fi

  jq -n -c --argjson volume "$volume" --arg mute "$mute" --arg symbol "$symbol" '{volume: $volume, mute: $mute, symbol: $symbol}'

  read -r _
do true; done
