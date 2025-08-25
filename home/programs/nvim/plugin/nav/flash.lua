later(function()
  vim.cmd.packadd("flash.nvim")
  require("flash").setup({
    labels = "arstneiodhwfuy",
  })

  keymap({ "n", "v", "o" }, "s", function()
    require("flash").jump()
  end, { desc = "flash search" })

  keymap("o", "r", function()
    require("flash").remote()
  end, { desc = "flash remote" })
end)
