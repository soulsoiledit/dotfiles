later(function()
  vim.cmd("packadd nvim-treesitter")
  require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
  })

  vim.cmd("packadd rainbow-delimiters.nvim")
  vim.cmd("doautoall TSRainbowDelimits FileType")
end)
