vim.diagnostic.config({
  virtual_lines = { current_line = true },
  severity_sort = true,
  update_in_insert = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " "
    }
  }
})

vim.lsp.inlay_hint.enable()

vim.lsp.config('*', {
  root_markers = { ".git" },
  on_attach = function(client, bufnr)
    require("lz.n").trigger_load("lsp-format.nvim")
    require("lsp-format").on_attach(client, bufnr)

    vim.keymap.set(
      "n", "gd", vim.lsp.buf.definition,
      { desc = "goto def" }
    )
    vim.keymap.set(
      "n", "gD", vim.lsp.buf.declaration,
      { desc = "goto dec" }
    )
    vim.keymap.set(
      "n", "grt", vim.lsp.buf.type_definition,
      { desc = "goto type" }
    )
  end
})

vim.lsp.enable({
  "luals",

  "nil",
  "nixd",

  "basedpyright",
  "ruff",

  "rustanalyzer",
  "hls",
  "zls",

  "bashls",
  "fishls",

  "iwe",
  "marksman",
  "texlab",
  "tinymist",

  "htmlls",
  "cssls",
  "vtsls",
  "biome",

  "jsonls",
  "yamlls",
  "taplo",

  "rubyls",
  "jdtls",
  "kotlinls",
  "clangd",
})
