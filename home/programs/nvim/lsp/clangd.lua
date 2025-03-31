---@type vim.lsp.Config
return {
  cmd = { "clangd" },
  filetypes = {
    "c",
    "cpp",
    "objc",
    "objcpp",
    "cuda",
    "proto"
  },
  root_markers = {
    ".git",
    ".clangd",
    ".clang-tidy",
    ".clang-format",
  },

  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { "utf-8", "utf-16" },
  },
}
