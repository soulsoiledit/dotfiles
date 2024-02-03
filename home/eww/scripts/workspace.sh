workspaces=$(hyprctl workspaces | rg -o 'workspace ID (\d)' -r '$1')
active=$(hyprctl activeworkspace | rg -o 'workspace ID (\d)' -r '$1')

output=""
for ws in $(seq 1 5); do
	icon=""

	if [[ $active == $ws ]]; then
		icon=""
	else
		if [[ $workspaces == *"${ws}"* ]]; then
			icon=""
		else
			icon=""
		fi
	fi

	output="$output $icon"
done

echo $output
