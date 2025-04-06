return {
  {
    "nvim-lightbulb",
    event = "DeferredUIEnter",
    after = function()
      require("nvim-lightbulb").setup({
        autocmd = { enabled = true },
        sign = {
          text = "",
          lens_text = "",
        },
      })
    end,
  },

  {
    "mini.cursorword",
    event = "DeferredUIEnter",
    after = function()
      require("mini.cursorword").setup()
    end,
  },

  {
    "mini.trailspace",
    event = "DeferredUIEnter",
    after = function()
      require("mini.trailspace").setup()
    end
  },
}
