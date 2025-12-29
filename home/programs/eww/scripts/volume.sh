previous=
pw-mon -o | while read -r line; do
  # ignore this check if it's the first iteration
  # check if the output doesn't have an indicator for modified volume
  if [[ $previous && ! $line =~ \*[[:blank:]]*params: ]]; then
    continue
  fi

  while true; do
    # get sink device name
    device=$(wpctl inspect @DEFAULT_AUDIO_SINK@)
    [[ $device =~ node.description.=.\"([[:graph:][:blank:]]*)\" ]]
    device=${BASH_REMATCH[1]}

    # get sink volume and mute status
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    [[ $volume =~ ([[:digit:]]).([[:digit:]]{2}).?\[?(MUTED)?\]? ]]
    percentage=$((10#${BASH_REMATCH[1]}${BASH_REMATCH[2]}))
    muted=${BASH_REMATCH[3]}

    status="${device} ${percentage} ${muted}"
    if [[ $status ]]; then
      break
    fi
  done

  # skip if status was the same
  if [[ $status == "$previous" ]]; then
    continue
  fi

  # assign the symbols for volume and mute
  if [[ $muted ]]; then
    muted=true
    symbol=''
  else
    muted=false
    symbols=("" "" "")
    symbol=${symbols[((($percentage * 3 - 1) / 100))]}
  fi

  # send notifications only after first iteration
  if [[ $previous ]]; then
    notify-send "$symbol  $percentage%" \
      -h int:value:"$percentage" \
      -h string:x-canonical-private-synchronous:volume
  fi

  jq -nc \
    --arg symbol "$symbol" \
    --arg device "$device" \
    --arg percentage "$percentage" \
    --arg muted "$muted" \
    '{symbol: $symbol, device: $device, percentage: $percentage, muted: $muted}'

  # set previous
  previous=$status
done
