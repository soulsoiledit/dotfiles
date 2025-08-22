later(function()
  vim.cmd("packadd todo-comments.nvim")
  require("todo-comments").setup()

  keymap("n", "<leader>t", function()
    require("snacks").picker.todo_comments()
  end, { desc = "todo" })
end)
