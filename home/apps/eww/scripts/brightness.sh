udevadm monitor -u -s backlight | while read -r line; do
  # look for changed brightness lines
  [[ "$line" =~ change\ +/(devices/[^ ]+)\ \(backlight\) ]] || continue

  # get current and max brightness
  backlight_path="/sys/${BASH_REMATCH[1]}"
  [[ -d $backlight_path ]] || continue
  current=$(<"$backlight_path/brightness")
  max=$(<"$backlight_path/max_brightness")

  # find percentage and symbols
  perc=$((current * 100 / max))
  symbols=('󰽤' '' '' '' '' '󰃠')
  symbol=${symbols[$((perc * 6 / 101))]}

  notify-send "$symbol  $perc%" \
    -u low \
    -t 1000 \
    -h int:value:"$perc" \
    -h string:x-canonical-private-synchronous:brightness-change
done
