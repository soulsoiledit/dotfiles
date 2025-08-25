later(function()
  vim.cmd.packadd("nvim-lightbulb")
  require("nvim-lightbulb").setup({
    autocmd = { enabled = true },
    sign = {
      text = "",
      lens_text = "",
    },
  })
end)
