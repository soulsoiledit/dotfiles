safely("now", function ()
  local snacks = require("snacks")
  snacks.setup({
    picker = {},
    dashboard = {
      sections = {
        { section = "header" },
        { gap = 1, padding = 1, section = "keys" }
      },
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
            action = function ()
              snacks.picker.smart()
            end
          },
          {
            icon = " ",
            key = "s",
            desc = "Search Text",
            action = function ()
              snacks.picker.grep()
            end
          },
          {
            icon = " ",
            key = "n",
            desc = "New File",
            action = ":ene | startinsert"
          },
          {
            icon = " ",
            key = "q",
            desc = "Quit",
            action = ":qa"
          }
        }
      }
    }
  })

  vim.api.nvim_set_hl(0, "SnacksNormal", { link = "Normal" })
  vim.api.nvim_set_hl(0, "SnacksPicker", { link = "Normal" })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder", { link = "Comment" })

  nmap("<leader>f", snacks.picker.smart, "files")
  nmap("<leader>s", snacks.picker.grep, "search")
  nmap("<leader>r", snacks.picker.commands, "commands")
  nmap("<leader>d", snacks.picker.diagnostics, "diagnostics")
  nmap("<leader>p", snacks.picker.pickers, "pickers")
end)
