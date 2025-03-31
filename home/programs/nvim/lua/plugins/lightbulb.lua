return {
  "nvim-lightbulb",
  event = "DeferredUIEnter",
  after = function()
    require("nvim-lightbulb").setup()
  end,
}
