local prettier = {
  formatCommand = "prettier --stdin-filepath '${INPUT}'",
  formatStdin = true,
  rootMarkers = { '.prettierrc', 'package.json' },
}

---@type vim.lsp.Config
return {
  cmd = { "efm-langserver" },
  filetypes = {
    "html",
    "scss",
    "less",
    "yaml",
  },
  init_options = { documentFormatting = true },
  settings = {
    languages = {
      html = { prettier },
      scss = { prettier },
      less = { prettier },
      yaml = { prettier },
    }
  }
}
