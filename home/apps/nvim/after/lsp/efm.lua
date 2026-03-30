local prettier = {
  formatCommand = "prettier --stdin-filepath '${INPUT}' ${--tab-width:tabSize} ${--use-tabs:!insertSpaces}",
  formatStdin = true,
  rootMarkers = { ".prettierrc", "package.json" },
}

---@type vim.lsp.Config
return {
  filetypes = {
    "markdown",
    "less",
    "scss",
  },
  init_options = { documentFormatting = true },
  settings = {
    languages = {
      markdown = { prettier },
      less = { prettier },
      scss = { prettier },
    },
  },
}
