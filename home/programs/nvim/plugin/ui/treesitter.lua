vim.api.nvim_create_autocmd("UIEnter", {
  callback = function(_ev)
    vim.cmd("packadd nvim-treesitter")
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },
      indent = { enable = true },
    })

    vim.cmd("packadd rainbow-delimiters.nvim")
    vim.cmd("doautoall TSRainbowDelimits FileType")
  end,
})
