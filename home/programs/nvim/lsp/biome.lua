---@type vim.lsp.Config
return {
  cmd = {
    "biome",
    "lsp-proxy",
    "--config-path",
    "/home/soil/.config/biome.json"
  },
  filetypes = {
    "css",
    "graphql",
    "json", "jsonc",
    "javascript", "javascriptreact",
    "typescript", "typescript.tsx", "typescriptreact",
    "astro", "svelte", "vue",
  },
  root_markers = { ".git", "biome.json" },
}
