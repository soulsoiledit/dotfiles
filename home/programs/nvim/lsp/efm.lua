local prettier = {
  formatCommand = "prettier --stdin-filepath '${INPUT}'",
  formatStdin = true,
  rootMarkers = { ".prettierrc", "package.json" },
}

---@type vim.lsp.Config
return {
  cmd = { "efm-langserver" },
  filetypes = {
    "markdown",
    "scss",
    "less",
    "yaml",
  },
  init_options = { documentFormatting = true },
  settings = {
    languages = {
      markdown = { prettier },
      scss = { prettier },
      less = { prettier },
      yaml = { prettier },
    }
  }
}
