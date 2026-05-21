until wpctl get-volume @DEFAULT_AUDIO_SINK@ &>/dev/null; do
  sleep 0.1
done

previous=
pw-mon -o | while read -r line; do
  # check if the output doesn't have an indicator for modified volume
  [[ $line =~ ^\*.+params: ]] || continue

  # get sink volume and mute status
  volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
  [[ -z $volume ]] && continue

  # split into percentage and mute
  [[ $volume =~ ([0-9])\.([0-9]{2})(.*) ]]
  percentage=$((10#${BASH_REMATCH[1]}${BASH_REMATCH[2]}))
  muted=${BASH_REMATCH[3]}

  # get sink device name
  device=$(wpctl inspect @DEFAULT_AUDIO_SINK@ | rg "node.description")
  [[ $device =~ \"([[:print:]]+)\" ]]
  device=${BASH_REMATCH[1]}

  # skip if status was the same
  status="${device} ${percentage} ${muted}"
  [[ $status == "$previous" ]] && continue

  # assign the symbols for volume and mute
  if [[ -n $muted ]]; then
    muted=true
    symbol=''
  else
    muted=false
    symbols=("" "" "")
    id=$((percentage * 3 / 101))
    ((id > 2)) && id=2
    symbol=${symbols[$id]}
  fi

  # send notifications only after first iteration
  if [[ -n $previous ]]; then
    notify-send "$symbol  $percentage%" \
      -u low \
      -h int:value:"$percentage" \
      -h string:x-canonical-private-synchronous:volume
  fi

  jq -nc \
    --arg symbol "$symbol" \
    --arg device "$device" \
    --argjson percentage "$percentage" \
    --argjson muted "$muted" \
    '{$symbol, $device, $percentage, $muted}'

  # set previous
  previous=$status
done
