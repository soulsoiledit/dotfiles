prev=
pw-mon -N | while read -r line; do
  if ! [[ $line =~ \*[[:blank:]]*params: ]]; then
    continue
  fi

  volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

  if [[ $volume == "$prev" ]]; then
    continue
  fi

  # record previous output
  prev=$volume

  # get volume
  [[ "$volume" =~ ([0-9])\.([0-9]{2})(.\[MUTED\])? ]]
  volume=$((10#${BASH_REMATCH[1]}${BASH_REMATCH[2]}))

  # get muted status & assign symbols
  if [[ -n ${BASH_REMATCH[3]} ]]; then
    mute=true
    symbol=''
  else
    mute=false
    symbols=("" "" "")
    symbol=${symbols[((($volume * 3 - 1) / 100))]}
  fi

  # send progress notification
  notify-send "$symbol  $volume%" -h int:value:"$volume" -h string:x-canonical-private-synchronous:volume

  # output json for eww
  jq -nc --argjson volume "$volume" --argjson mute "$mute" --arg symbol "$symbol" '{volume: $volume, mute: $mute, symbol: $symbol}'
done
