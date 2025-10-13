---@type vim.lsp.Config
return {
  -- allow biome lsp-proxy to attach to standalone files
  workspace_required = false,
  root_dir = false,
  root_markers = { { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }, ".git" },

  settings = {
    biome = {
      configurationPath = vim.fs.normalize("$XDG_CONFIG_HOME/biome/config.json"),
    },
  },
}
