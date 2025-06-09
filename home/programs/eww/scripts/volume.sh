pw-mon | grep --line-buffered "\*.*params:" | while read -r _; do
  out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

  # get volume
  if [[ "$out" =~ ([0-9])\.([0-9]{2}) ]]; then
    volume=$((10#${BASH_REMATCH[1]}${BASH_REMATCH[2]}))
  fi

  # get muted status & assign symbols
  if [[ "$out" == *"MUTED"* ]]; then
    mute=true
    symbol=''
  else
    mute=false
    symbols=("" "" "")
    symbol=${symbols[(((10#$volume * 3 - 1) / 100))]}
  fi

  # send progress notification
  notify-send "$symbol  $volume%" -h int:value:"$volume" -h string:x-canonical-private-synchronous:volume

  # output json for eww
  jq -nc --argjson volume "$volume" --argjson mute "$mute" --arg symbol "$symbol" '{volume: $volume, mute: $mute, symbol: $symbol}'
done
