---@type vim.lsp.Config
return {
  cmd = { "vtsls", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = {
    ".git",
    "tsconfig.json",
    "jsconfig.json",
    "package.json",
  },
  settings = {
    javascript = { format = { enable = false } },
    typescript = { format = { enable = false } },
  },
}
