vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    vim.cmd.packadd("lsp-format.nvim")
    require("lsp-format").setup()

    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    require("lsp-format").on_attach(client, ev.buf)
  end,
})
