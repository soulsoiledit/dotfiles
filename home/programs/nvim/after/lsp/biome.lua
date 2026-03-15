---@type vim.lsp.Config
return {
  -- allow biome lsp-proxy to attach to standalone files
  workspace_required = false,
  root_dir = false,
  root_markers = {
    { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock", "deno.lock" },
    ".git",
  },

  before_init = function(_params, config)
    -- reset settings if biome.json or biome.jsonc found in current or parent directories
    if vim.fs.root(0, { { "biome.json", "biome.jsonc" } }) and config.settings then
      config.settings.biome = {}
    end
  end,

  settings = {
    biome = {
      inlineConfig = {
        formatter = { indentStyle = "space" },
        html = { formatter = { enabled = true } },
      },
    },
  },
}
