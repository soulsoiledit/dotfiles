now(function()
  require("markview").setup()
  vim.api.nvim_set_hl(0, "MarkviewListItemMinus", { link = "MarkviewPalette6Fg" })
  vim.api.nvim_set_hl(0, "MarkviewListItemStar", { link = "MarkviewPalette2Fg" })
end)

later(function()
  vim.cmd.packadd("rainbow-delimiters.nvim")
end)

now_if_args(function()
  vim.cmd.packadd("nvim-colorizer.lua")
  require("colorizer").setup({
    lazy_load = true,
    user_default_options = {
      AARRGGBB = true,
      css = true,
    },
  })
end)

later(function()
  vim.cmd.packadd("nvim-lightbulb")
  require("nvim-lightbulb").setup({
    autocmd = { enabled = true },
    sign = {
      text = "",
      lens_text = "",
    },
  })
end)

later(function()
  vim.cmd.packadd("which-key.nvim")
  require("which-key").setup({
    win = { height = { min = 5, max = 10 } },
    spec = {
      { "gr", group = "refactor" },
      { "gra", desc = "code action" },
      { "gri", desc = "implementation" },
      { "grn", desc = "rename" },
      { "grr", desc = "reference" },
      { "grt", desc = "type definition" },
    },
  })
end)
