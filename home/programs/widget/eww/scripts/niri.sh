echo '"EventStream"' | socat -,ignoreeof "$NIRI_SOCKET",ignoreeof | rg "WorkspaceActivated|WorkspacesChanged" --line-buffered | while
  niri msg --json workspaces | jq -c 'sort_by(.id)'
  read -r _
do
  continue
done
