previous=
pw-mon | while read -r line; do
  # ignore this check if it's the first iteration
  # check if the output doesn't have an indicator for modified volume
  if [[ $previous && ! $line =~ \*[[:blank:]]*params: ]]; then
    continue
  fi

  while true; do
    status=$(wpctl status -k)
    # get the device name, volume, and muted
    [[ $status =~ \*[^.]*\..([[:graph:][:blank:]]*)\[vol:.([[:digit:]]).([[:digit:]]{2}).?(MUTED)?\] ]]
    status=${BASH_REMATCH[0]}
    if [[ -z $status ]]; then
      continue
    fi
    # trim trailing whitespace
    device="${BASH_REMATCH[1]%"${BASH_REMATCH[1]##*[![:space:]]}"}"
    percentage=$((10#${BASH_REMATCH[2]}${BASH_REMATCH[3]}))
    muted=${BASH_REMATCH[4]}
    break
  done

  # skip if status was the same
  if [[ $status == "$previous" ]]; then
    continue
  fi

  # parse the muted status & assign symbols
  if [[ -n $muted ]]; then
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
