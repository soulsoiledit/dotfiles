previous=
pw-mon | while read -r line; do
  # ignore this check if it's the first iteration
  # check if the output doesn't have an indicator for modified volume
  if [[ $previous && ! $line =~ \*[[:blank:]]*params: ]]; then
    continue
  fi

  out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
  if [[ $out == "$previous" ]]; then
    continue
  fi
  previous=$out

  # parse the volume
  [[ "$out" =~ ([0-9])\.([0-9]{2})(.\[MUTED\])? ]]
  percentage=$((10#${BASH_REMATCH[1]}${BASH_REMATCH[2]}))

  # parse the muted status & assign symbols
  if [[ -n ${BASH_REMATCH[3]} ]]; then
    muted=true
    symbol=''
  else
    muted=false
    symbols=("" "" "")
    symbol=${symbols[((($percentage * 3 - 1) / 100))]}
  fi

  # don't send a notification on the first iteration
  if [[ $previous ]]; then
    notify-send "$symbol  $percentage%" \
      -h int:value:"$percentage" \
      -h string:x-canonical-private-synchronous:volume
  fi

  jq -nc \
    --arg symbol "$symbol" \
    --arg percentage "$percentage" \
    --arg muted "$muted" \
    '{symbol: $symbol, percentage: $percentage, muted: $muted}'
done
