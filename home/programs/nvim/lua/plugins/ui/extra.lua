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
}
