gdbus monitor -y -d "org.freedesktop.UPower.PowerProfiles" -o "/org/freedesktop/UPower/PowerProfiles" | while read -r line; do
  if [[ $line =~ \'ActiveProfile\':.\<\'([^\']+) ]]; then
    notify-send "  Power Profile:" "${BASH_REMATCH[1]}" \
      -c osd \
      -u low \
      -h string:x-canonical-private-synchronous:profile-switch
  fi
done
