later(function()
  local severity = vim.diagnostic.severity
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

now_if_args(function()
  vim.cmd.packadd("nvim-lspconfig")

  vim.lsp.set_log_level(vim.log.levels.OFF)
  vim.lsp.log.set_format_func(vim.inspect)

  vim.lsp.enable({
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
    "qmlls",
  })

  vim.lsp.inlay_hint.enable(true)

  vim.keymap.set("n", "gd", "<C-]>", { desc = "definition" })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "declaration" })
end)
