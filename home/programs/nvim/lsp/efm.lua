local prettier = {
  formatCommand = "prettier --stdin-filepath '${INPUT}'",
  formatStdin = true,
  rootMarkers = { ".prettierrc", "package.json" },
}

local topiary_yuck = {
  formatCommand = "topiary-yuck format --tolerate-parsing-errors --language yuck <'${INPUT}'",
  formatStdin = false,
  rootMarkers = { "eww.yuck", "eww.scss" }
}

---@type vim.lsp.Config
return {
  cmd = { "efm-langserver" },
  filetypes = {
    "markdown",
    "html",
    "scss",
    "less",
    "yaml",

    "yuck",
  },
  init_options = { documentFormatting = true },
  settings = {
    languages = {
      markdown = { prettier },
      html = { prettier },
      scss = { prettier },
      less = { prettier },
      yaml = { prettier },

      yuck = { topiary_yuck },
    }
  }
}
