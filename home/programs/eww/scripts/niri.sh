niri msg --json event-stream | while read -r _; do
  niri msg --json workspaces | jq -Mc 'sort_by(.idx)'
done
