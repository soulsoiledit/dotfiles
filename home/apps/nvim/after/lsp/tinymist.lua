vim.api.nvim_create_autocmd("LspAttach", {
  callback = function (args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "tinymist" then
      local bufnr = args.buf
      local function start_tinymist_preview()
        client:exec_cmd({
          command = "tinymist.startDefaultPreview",
          title = "LspTinymistPreview"
        }, { bufnr = bufnr })
      end

      vim.api.nvim_buf_create_user_command(bufnr, "LspTinymistPreview", start_tinymist_preview, {
        desc = "Start Preview"
      })
    end
  end
})

---@type vim.lsp.Config
return {
  settings = {
    exportPdf = "onSave"
  }
}
