workspaces() {
	WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries')
	ACTIVE_WORKSPACE=$(hyprctl activeworkspace -j | jq '.id')
	seq 1 5 | jq --argjson windows "${WORKSPACE_WINDOWS}" --arg active "${ACTIVE_WORKSPACE}" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0), active: $active})'
}

workspaces
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
	workspaces
done
