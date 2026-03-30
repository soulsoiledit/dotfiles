safely("event:UIEnter", function()
  vim.cmd.packadd("typst-preview.nvim")
  require("typst-preview").setup()
end)
