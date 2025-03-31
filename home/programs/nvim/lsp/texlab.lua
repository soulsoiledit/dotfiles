---@type vim.lsp.Config
return {
  cmd = { "texlab" },
  filetypes = { "tex", "plaintex", "bib" },
  root_markers = {
    ".git",
    ".latexmkrc",
    ".texlabroot",
    "texlabroot",
    "Tectonic.toml",
  },

  settings = {
    texlab = {
      build = {
        executable = "tectonic",
        args = {
          "-X",
          "compile",
          "%f",
          "--synctex",
          "--keep-logs",
          "--keep-intermediates",
        },
        forwardSearchAfter = true,
        onSave = true,
      },
      forwardSearch = {
        executable = "zathura",
        args = { "--synctex-forward", "%l:1:%f", "%p" },
      },
    },
  },
}
