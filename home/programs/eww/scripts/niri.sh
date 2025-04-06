niri msg --json event-stream | while
  niri msg --json workspaces | jq -Mc 'sort_by(.idx)'
  read -r _
do
  continue
done
