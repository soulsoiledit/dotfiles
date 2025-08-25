---@type vim.lsp.Config
return {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  root_markers = { ".git" },
  settings = {
    exportPdf = "onSave",
    formatterMode = "typstyle",
  },
}
