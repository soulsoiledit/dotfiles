vim.diagnostic.config({
  severity_sort = true,
  virtual_lines = { current_line = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  }
})

vim.lsp.config('*', {
  root_markers = { ".git" },
  on_attach = function(client, bufnr)
    vim.lsp.set_log_level(vim.log.levels.OFF)
    vim.lsp.log.set_format_func(vim.inspect)

    vim.lsp.inlay_hint.enable()

    vim.keymap.set(
      "n", "gd",
      vim.lsp.buf.definition,
      { desc = "goto def" }
    )
    vim.keymap.set(
      "n", "gD",
      vim.lsp.buf.declaration,
      { desc = "goto dec" }
    )
    vim.keymap.set(
      "n", "grt",
      vim.lsp.buf.type_definition,
      { desc = "goto type" }
    )

    require("lz.n").trigger_load("lsp-format.nvim")
    require("lsp-format").on_attach(client, bufnr)
  end
})

-- enable all lsp
local lsp_configs = {}
for _, file in pairs(vim.api.nvim_get_runtime_file("lsp/*lua", true)) do
  local lsp = vim.fn.fnamemodify(file, ":t:r")
  table.insert(lsp_configs, lsp)
end

vim.lsp.enable(lsp_configs)
