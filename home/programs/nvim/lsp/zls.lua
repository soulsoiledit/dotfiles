---@type vim.lsp.Config
return {
  cmd = { "zls" },
  filetypes = { "zig", "zir" },
  root_markers = { ".git", "zls.json", "build.zig" },
}
