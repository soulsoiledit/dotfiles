dbus-monitor --profile --system path=/org/freedesktop/UPower/PowerProfiles | while read -r line; do
  if [[ $line =~ PropertiesChanged ]]; then
    current=$(powerprofilesctl get)
    notify-send "  Profile:" "$current" -h string:x-canonical-private-synchronous:profile
  fi
done
