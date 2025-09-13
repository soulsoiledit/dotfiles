local snacks = require("snacks")
snacks.setup({
  lazygit = {},
  picker = {},

  notifier = {},
  indent = {
    indent = { enabled = false },
    scope = { hl = "Comment" },
  },

  input = {},
  styles = {
    input = {
      relative = "cursor",
      width = 32,
    },
  },

  dashboard = {
    preset = {
      header = [[
⠀⠀⠀⢀⠖⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠖⢣⠀⠀
⠀⠀⢀⠎⠀⠈⠣⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠊⠀⠀⠀⢇⠀
⠀⠀⡜⠀⠀⠀⠀⠙⢆⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⠀⠀⠀⡠⠋⠀⠀⠀⠀⠀⠸⡄
⠀⢰⠃⠀⠀⠀⠀⠀⠈⠣⡀⠀⢸⠀⠈⠉⠓⠦⡀⠀⠀⡼⠁⠀⠀⠀⠀⠀⠀⠀⡇
⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠙⢄⣈⡧⠀⠀⠀⠀⠈⠲⡼⠁⠀⠀⠀⠀⠀⠀⠀⠀⡇
⠀⣾⠀⠀⠀⠀⠀⠀⠀⠀⠴⣎⣁⣀⣤⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇
⠀⢹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇
⠀⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠀
⠀⠀⢧⠀⠀⠐⣲⠒⠒⣶⣶⣶⡆⠀⠀⠀⠀⠀⣶⣶⣶⡞⠛⢻⠛⠀⠀⠀⡰⠃⠀
⣤⠤⣄⣳⡀⠀⡇⠀⠀⣿⣿⣿⡇⠀⠀⠀⠀⠀⣿⣿⣿⡇⠀⠈⡇⠀⠐⠚⠒⢒⠆
⠘⢦⡀⠀⠀⠀⠣⠀⠀⠹⠿⠿⠁⠀⠀⠀⠀⠀⠻⠿⠿⠁⠀⠰⠃⠀⠀⢀⠔⠁⠀
⠀⠀⡸⠂⠠⢲⡠⠄⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀⠀⠀⠀⠀⠔⣦⠞⠀⠀⠑⣄⠀⠀
⠀⢠⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠢⠔⠊⠉⠒⠒⠁⠀⠀⠀⠀⠀⣀⣀⣀⣀⣈⡆⠀
⠀⠈⠉⠉⠉⠉⠑⠢⡤⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⢤⠤⠒⠋⠁⠀⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠑⢄⠀⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠳⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⡄⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠐⠓⢲⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀]],

      keys = {
        {
          icon = " ",
          key = "f",
          desc = "Find File",
          action = function()
            snacks.picker.smart()
          end,
        },
        {
          icon = " ",
          key = "s",
          desc = "Search Text",
          action = function()
            snacks.picker.grep()
          end,
        },
        {
          icon = " ",
          key = "n",
          desc = "New File",
          action = ":ene | startinsert",
        },
        {
          icon = " ",
          key = "q",
          desc = "Quit",
          action = ":qa",
        },
      },
    },
    sections = { { section = "header" }, { gap = 1, padding = 1, section = "keys" } },
  },
})

hl(0, "SnacksNormal", { link = "Normal" })
hl(0, "SnacksPicker", { link = "Normal" })
hl(0, "SnacksPickerBorder", { link = "Comment" })

keymap("n", "<leader>g", function()
  snacks.lazygit()
end, { desc = "git" })

-- picker
keymap("n", "<leader>f", function()
  snacks.picker.smart()
end, { desc = "files" })

keymap("n", "<leader>s", function()
  snacks.picker.grep()
end, { desc = "search" })

keymap("n", "<leader>r", function()
  snacks.picker.commands()
end, { desc = "commands" })

keymap("n", "<leader>p", function()
  snacks.picker()
end, { desc = "pickers" })
