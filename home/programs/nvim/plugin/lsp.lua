local severity = vim.diagnostic.severity
local lsp = vim.lsp

later(function()
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
end)

vim.cmd.packadd("nvim-lspconfig")

lsp.enable({
  "nil_ls",
  "emmylua_ls",

  "rust_analyzer",
  "hls",

  "html",
  "cssls",
  "vtsls",
  "biome",
  "efm",

  "pyrefly",
  "ruff",

  "bashls",
  "fish_lsp",

  "tinymist",

  "clangd",
  "jdtls",
  "qmlls",
})

lsp.set_log_level(vim.log.levels.OFF)
lsp.log.set_format_func(vim.inspect)
lsp.inlay_hint.enable(true)

keymap("n", "gd", "<C-]>", { desc = "go to definition" })
keymap("n", "gD", lsp.buf.declaration, { desc = "go to declaration" })
