dbus-monitor --system path=/org/freedesktop/UPower/PowerProfiles --profile | while read -r line; do
  if [[ $line =~ PropertiesChanged ]]; then
    notify-send "  Profile:" "$(powerprofilesctl get)" -h string:x-canonical-private-synchronous:volume
  fi
done
