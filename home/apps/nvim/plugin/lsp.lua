safely("now", function ()
  local severity = vim.diagnostic.severity
  vim.diagnostic.config({
    severity_sort = true,
    virtual_lines = { current_line = true },
    signs = {
      text = {
        [severity.ERROR] = "",
        [severity.WARN] = "",
        [severity.INFO] = "",
        [severity.HINT] = "󰌵"
      }
    }
  })
end)

safely_if_args("now", "later", function ()
  vim.cmd.packadd("nvim-lspconfig")

  vim.lsp.log.set_level(vim.log.levels.OFF)
  vim.lsp.log.set_format_func(vim.inspect)

  vim.lsp.enable({
    "nixd",
    "emmylua_ls",
    "rust_analyzer",
    "hls",
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
    "qmlls"
  })
end)

safely_if_args("now", "later", function ()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp.setup_features", {}),
    callback = function (args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

      if client:supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true)
      end

      vim.cmd.packadd("lsp-format.nvim")
      require("lsp-format").setup()
      require("lsp-format").on_attach(client, args.buf)
    end
  })
end)

vim.api.nvim_create_autocmd("LspProgress", {
  group = vim.api.nvim_create_augroup("lsp.echo_progress", {}),
  callback = function (args)
    local value = args.data.params.value
    vim.api.nvim_echo({ { value.message or "done" } }, false, {
      id = "lsp." .. args.data.params.token,
      kind = "progress",
      source = "vim.lsp",
      title = value.title,
      status = value.kind ~= "end" and "running" or "success",
      percent = value.percentage
    })
  end
})
