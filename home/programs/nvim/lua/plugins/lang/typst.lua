return {
  {
    "typst-preview.nvim",
    ft = "typst",
    after = function()
      require("typst-preview").setup({
        invert_colors = '{"rest": "auto", "image": "never"}',
      })
    end,
  },
}
