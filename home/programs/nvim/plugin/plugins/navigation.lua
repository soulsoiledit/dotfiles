later(function()
  vim.cmd.packadd("flash.nvim")
  local flash = require("flash")
  flash.setup({ labels = "arstneiodhwfuy" })

  vim.keymap.set({ "n", "v", "o" }, "s", flash.jump, { desc = "flash search" })
  vim.keymap.set("o", "r", flash.remote, { desc = "flash remote" })
end)

later(function()
  vim.cmd.packadd("grug-far.nvim")
  require("grug-far").setup()
end)

later(function()
  vim.cmd.packadd("todo-comments.nvim")
  require("todo-comments").setup()
  vim.keymap.set("n", "<leader>t", require("snacks").picker.todo_comments, { desc = "todo" })
end)
