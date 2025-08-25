later(function()
  vim.cmd.packadd("trouble.nvim")
  require("trouble").setup()

  keymap("n", "<leader>d", function()
    require("trouble").toggle("diagnostics")
  end, { desc = "trouble" })
end)
