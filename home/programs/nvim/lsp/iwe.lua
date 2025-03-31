---@type vim.lsp.Config
return {
  cmd = { "iwes" },
  filetypes = { "markdown" },
  root_markers = { ".git", ".iwe" },
  flags = {
    debounce_text_changes = 500,
    exit_timeout = false,
  }
}
