local prettier = {
  formatCommand = "prettier --stdin-filepath '${INPUT}'",
  formatStdin = true,
  rootMarkers = { ".prettierrc", "package.json" },
}

---@type vim.lsp.Config
return {
  filetypes = {
    "markdown",
    "html",
    "less",
    "scss",
  },
  init_options = { documentFormatting = true },
  settings = {
    languages = {
      markdown = { prettier },
      html = { prettier },
      less = { prettier },
      scss = { prettier },
    },
  },
}
