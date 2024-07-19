active() {
  socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while
    hyprctl activeworkspace -j | jq -c
    read -r _
  do continue; done
}

empty() {
  socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while
    hyprctl workspaces -j | jq -c 'map({key: .id | tostring, value: .windows}) | from_entries'
    read -r _
  do continue; done
}

list() {
  seq 1 5 | jq -c --slurp '.'
}

case "$1" in
"active") active ;;
"empty") empty ;;
"list") list ;;
esac
