---@type vim.lsp.Config
return {
  init_options = {
    settings = {
      configurationPreference = "filesystemFirst",
      configuration = {
        ["indent-width"] = 2,
      },
    },
  },
}
