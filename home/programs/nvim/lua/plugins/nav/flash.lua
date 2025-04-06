return {
  {
    "flash.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("flash").setup({
        labels = "arstneiodhwfpluycxgmqzbjvk"
      })
    end,
    keys = {
      {
        mode = { "n", "v", "o" },
        "s",
        function()
          require("flash").jump()
        end,
        desc = "flash search",
      },
      {
        mode = "o",
        "r",
        function()
          require("flash").remote()
        end,
        desc = "flash remote",
      },
    },
  },
}
