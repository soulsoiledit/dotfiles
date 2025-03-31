return {
  "rainbow-delimiters.nvim",
  event = "DeferredUIEnter",
  after = function()
    vim.cmd("doautoall TSRainbowDelimits FileType")
  end,
}
