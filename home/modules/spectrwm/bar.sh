#! /usr/bin/env bash

bat() {
bat=$(acpi -b)
if [[ $bat == *"Full"* ]]
then echo ""
else
  state=$(echo $bat | grep -Po "\d{1,3}%|\d{1,2}:\d{1,2}" | xargs)
  if [[ $bat =~ "Charging" ]]
    then echo "+@fg=3; $state+@fg=0;"
  else if [[ $bat =~ "Discharging" ]]
    then if (( $(echo $bat | grep -Po "\d{1,3}%?(?=%)") < 15 ))
  then
    echo "+@fg=1;+@fg=0;"
    dunstify -u critical "Low Battery!"
  else
    echo "+@fg=2; $state+@fg=0;"
  fi
  fi
  fi
  fi
}

temp() {
  temp=$(acpi -t | grep -Po '\d{2}')
  if (( $temp < 90 ))
    then echo "﨎 $temp°C"
  else if (( $temp < 95 ))
    then echo "+@fg=2; $temp°C+@fg=0;"
  else
    echo "+@fg=1; $temp°C+@fg=0;"
  fi
  fi
}

mem() {
  mem=$(free | awk '/Mem/{printf("%d"), ($2-$7)/$2*100}')
  if (( $mem < 95 ))
    then echo " $mem%"
  else
    echo "+@fg=1; $mem%+@fg=0;"
  fi
}

net() {
  net=$(connmanctl services | grep "*A[OR]")
  if [ -z "$net" ]
    then echo "+@fg=4;睊 +@fg=0;"
  else
    echo "直 "
  fi
}

vol() {
  muted=$(pactl list sinks | grep -A 10 "Name: bluez" | awk /'Mute'/'{print $2}')
  if [[ $muted == "no" ]]
  then echo "墳 $(pactl list sinks | grep -A 10 "Name: bluez" | awk /'Volume: f'/'{print $5}')"
  else if [[ $muted == "yes" ]]
    then echo "ﱝ "
  else
    echo "+@fg=4;ﱝ +@fg=0;"
  fi
  fi
}

cal() {
  date +'%a %m-%d %H:%M'
}

while true; do
  echo "$(bat) $(temp) $(mem) $(net) $(vol) $(cal)"
  sleep 1
done
