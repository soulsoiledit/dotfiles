vim.api.nvim_create_autocmd("LspAttach", {
  callback = function (args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "tinymist" then
      local bufnr = args.buf
      vim.api.nvim_buf_create_user_command(
        bufnr, "LspTinymistStartPreview",
        function ()
          client:exec_cmd({
            command = "tinymist.doKillPreview",
            title = "LspTinymistKillPreview",
            arguments = { "default_preview" }
          }, { bufnr = bufnr }, function () return nil end)
          client:exec_cmd({
            command = "tinymist.startDefaultPreview",
            title = "LspTinymistStartPreview"
          }, { bufnr = bufnr })
        end,
        {
          desc = "Start default preview"
        }
      )

      vim.api.nvim_buf_create_user_command(
        bufnr, "LspTinymistScrollPreview",
        function ()
          local line, character = unpack(vim.api.nvim_win_get_cursor(0))
          client:exec_cmd({
            command = "tinymist.scrollPreview",
            title = "LspTinymistScrollPreview",
            arguments = {
              "default_preview",
              {
                event = "panelScrollTo",
                filepath = vim.api.nvim_buf_get_name(bufnr),
                line = line - 1,
                character = character
              }
            }
          }, { bufnr = bufnr })
        end,
        {
          desc = "Scroll preview to cursor"
        }
      )
    end
  end
})

---@type vim.lsp.Config
return {
  settings = {
    exportPdf = "onSave"
  }
}
