---@type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    ".git",
    "pyproject.toml",
    "ruff.toml",
    ".ruff.toml",
  },
  init_options = {
    settings = {
      configurationPreference = "filesystemFirst",
      configuration = {
        ["indent-width"] = 2,
      },
    },
  },
}
