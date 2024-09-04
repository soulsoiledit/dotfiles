active() {
  id=$(bash -c "niri msg workspaces" | rg -o '\* (\d)' -r '$1')
  jq -n -c --arg id "$id" '{ id: $id }'
}

empty() {
  return
}

case "$1" in
"active") active ;;
"empty") empty ;;
esac
