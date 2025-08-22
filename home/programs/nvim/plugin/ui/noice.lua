later(function()
  vim.cmd("packadd noice.nvim")
  require("noice").setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
      signature = { enabled = false },
    },
    presets = {
      long_message_to_split = true,
      command_palette = true,
      bottom_search = true,
    },
  })
end)
