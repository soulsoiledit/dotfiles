niri msg --json event-stream | rg "WorkspaceActivated|WorkspacesChanged" --line-buffered | while
  niri msg --json workspaces | jq -c 'sort_by(.id)'
  read -r _
do continue; done
