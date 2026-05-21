previous=
niri msg event-stream | while read -r _; do
  current=$(niri msg -j workspaces | jq -c 'sort_by(.idx)')
  if [[ "$current" != "$previous" ]]; then
    echo "$current"
    previous="$current"
  fi
done
