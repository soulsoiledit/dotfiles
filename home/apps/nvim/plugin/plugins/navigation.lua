safely("event:UIEnter", function ()
  local flash = require("flash")
  flash.setup({ labels = "arstneio" })

  vim.keymap.set({ "n", "v", "o" }, "s", flash.jump, { desc = "flash search" })
  vim.keymap.set("o", "r", flash.remote, { desc = "flash remote" })
end)

safely("event:UIEnter", function ()
  require("todo-comments").setup()
  nmap("<leader>t", require("snacks").picker.todo_comments, "todo")
end)
