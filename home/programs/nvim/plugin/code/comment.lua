later(function()
  vim.cmd("packadd ts-comments.nvim")
  require("ts-comments").setup({
    lang = {
      yuck = ";; %s",
    },
  })
end)
