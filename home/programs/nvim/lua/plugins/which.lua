return {
  "which-key.nvim",
  event = "DeferredUIEnter",
  after = function()
    require("which-key").setup({
      spec = {
        { "gra",       desc = "code action" },
        { "gri",       desc = "goto imp" },
        { "grn",       desc = "rename" },
        { "grr",       desc = "goto ref" },

        { "<leader>w", proxy = "<c-w>" },
      }
    })
  end,
}
