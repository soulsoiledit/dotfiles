return {
  {
    "nvim-colorizer.lua",
    event = "DeferredUIEnter",
    after = function()
      require("colorizer").setup({
        lazy_load = true,
        user_commands = true,
        user_default_options = {
          AARRGGBB = true,
          css = true,
          tailwind = "lsp"
        },
      })
    end,
  },
}
