niri msg event-stream | while read -r _; do
  niri msg -j workspaces | jq -c 'sort_by(.idx)'
done
