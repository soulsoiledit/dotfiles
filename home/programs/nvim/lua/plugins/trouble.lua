return {
  "trouble.nvim",
  cmd = "Trouble",
  after = function()
    require("trouble").setup()
  end,
  keys = {
    {
      "<leader>d",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "trouble"
    }
  },
}
