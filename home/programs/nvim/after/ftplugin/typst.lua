later(function()
  vim.cmd.packadd("typst-preview.nvim")
  require("typst-preview").setup({
    invert_colors = '{"rest": "auto", "image": "never"}',
  })
end)
