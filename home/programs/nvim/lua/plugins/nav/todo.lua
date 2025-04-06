return {
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
}
