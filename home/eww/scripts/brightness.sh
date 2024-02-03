brightness=$(brightnessctl -m | rg '(\d+)%' -or '$1')

if (($brightness < 20)); then
	icon="󰽤 "
elif (($brightness >= 20 && $brightness < 40)); then
	icon="󰽥 "
elif (($brightness >= 40 && $brightness < 60)); then
	icon="󰽣 "
elif (($brightness >= 60 && $brightness < 80)); then
	icon="󰽦 "
elif (($brightness >= 80 && $brightness < 100)); then
	icon="󰽢 "
elif (($brightness >= 100)); then
	icon=" "
fi

echo $icon
