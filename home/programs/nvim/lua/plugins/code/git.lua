return {
  {
    "mini.diff",
    event = "DeferredUIEnter",
    after = function()
      require("mini.diff").setup({
        view = {
          style = "sign",
        },
      })
    end
  },
}
