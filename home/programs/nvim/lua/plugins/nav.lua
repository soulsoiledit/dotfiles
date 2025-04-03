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

  {
    "todo-comments.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("todo-comments").setup()
    end,
    keys = {
      {
        "<leader>t",
        function()
          require("snacks").picker.todo_comments()
        end,
        desc = "todo",
      }
    },
  },

  {
    "trouble.nvim",
    cmd = "Trouble",
    after = function()
      require("trouble").setup()
    end,
    keys = {
      {
        "<leader>d",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "trouble"
      }
    },
  },

  {
    "grug-far.nvim",
    cmd = "GrugFar",
    after = function()
      require("grug-far").setup()
    end,
  },
}
