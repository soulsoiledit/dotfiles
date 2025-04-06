return {
  {
    "mini.base16",
    after = function()
      require("mini.base16").setup({
        palette = mini_base16_palette,
      })

      vim.api.nvim_set_hl(0, "markdownH1", { fg = mini_base16_palette.base08 })
      vim.api.nvim_set_hl(0, "markdownH2", { fg = mini_base16_palette.base09 })
      vim.api.nvim_set_hl(0, "markdownH3", { fg = mini_base16_palette.base0A })
      vim.api.nvim_set_hl(0, "markdownH4", { fg = mini_base16_palette.base0B })
      vim.api.nvim_set_hl(0, "markdownH5", { fg = mini_base16_palette.base0C })
      vim.api.nvim_set_hl(0, "markdownH6", { fg = mini_base16_palette.base0D })
    end
  },
}
