return {
  "lualine.nvim",
  event = "DeferredUIEnter",
  after = function()
    require("lualine").setup({
      options = {
        disabled_filetypes = { "snacks_dashboard" }
      }
    })
  end,
}
