local severity = vim.diagnostic.severity
local lsp = vim.lsp

vim.diagnostic.config({
  severity_sort = true,
  virtual_lines = { current_line = true },
  signs = {
    text = {
      [severity.ERROR] = "",
      [severity.WARN] = "",
      [severity.INFO] = "",
      [severity.HINT] = "󰌵",
    },
  },
})

lsp.set_log_level(vim.log.levels.OFF)
lsp.log.set_format_func(vim.inspect)

-- add all enabled lsps
local lsps = {}
for _, file in pairs(vim.api.nvim_get_runtime_file("lsp/*lua", true)) do
  table.insert(lsps, vim.fn.fnamemodify(file, ":t:r"))
end

lsp.enable(lsps)

lsp.inlay_hint.enable()

keymap("n", "gd", lsp.buf.definition, { desc = "go to definition" })

keymap("n", "gD", lsp.buf.declaration, { desc = "go to declaration" })
