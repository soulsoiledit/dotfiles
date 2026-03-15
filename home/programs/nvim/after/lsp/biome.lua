-- search for biome.json or biome.jsonc in current or parent directories
local project_files = vim.fs.find({ "biome.json", "biome.jsonc" }, { upward = true, stop = "~" })
local has_project_config = #project_files > 0

---@type vim.lsp.Config
return {
  -- allow biome lsp-proxy to attach to standalone files
  workspace_required = false,
  root_dir = false,
  root_markers = { { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }, ".git" },

  settings = {
    biome = {
      -- do not configure if project already has configuration
      inlineConfig = has_project_config and {} or {
        formatter = { indentStyle = "space" },
        html = { formatter = { enabled = true } },
      },
    },
  },
}
