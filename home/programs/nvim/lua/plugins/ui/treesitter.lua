return {
  {
    "nvim-treesitter",
    lazy = true,
    after = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
