---@type vim.lsp.Config
return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    ".git",
    "requirements.txt",
    "pyproject.toml",
    "pyrightconfig.json"
  },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
      }
    }
  }
}
