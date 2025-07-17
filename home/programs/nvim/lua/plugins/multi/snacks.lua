return {
  "snacks.nvim",
  lazy = false,
  after = function()
    require("snacks").setup({
      lazygit = {},
      picker = {},

      notifier = {},
      indent = {
        indent = { enabled = false },
        scope = { hl = "Comment" }
      },

      input = {},
      styles = {
        input = {
          relative = "cursor",
          width = 32,
        }
      },

      dashboard = {
        preset = {
          header = [[
⠀⠀⠀⠀⠀⢀⠖⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠖⢣⠀⠀⠀⠀
⠀⠀⠀⠀⢀⠎⠀⠈⠣⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠊⠀⠀⠀⢇⠀⠀⠀
⠀⠀⠀⠀⡜⠀⠀⠀⠀⠙⢆⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⠀⠀⠀⡠⠋⠀⠀⠀⠀⠀⠸⡄⠀⠀
⠀⠀⠀⢰⠃⠀⠀⠀⠀⠀⠈⠣⡀⠀⢸⠀⠈⠉⠓⠦⡀⠀⠀⡼⠁⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀
⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠙⢄⣈⡧⠀⠀⠀⠀⠈⠲⡼⠁⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀
⠀⠀⠀⣾⠀⠀⠀⠀⠀⠀⠀⠀⠴⣎⣁⣀⣤⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀
⠀⠀⠀⢹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀
⠀⠀⠀⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠀⠀⠀
⠀⠀⠀⠀⢧⠀⠀⠐⣲⠒⠒⣶⣶⣶⡆⠀⠀⠀⠀⠀⣶⣶⣶⡞⠛⢻⠛⠀⠀⠀⡰⠃⠀⠀⠀
⠀⠀⣤⠤⣄⣳⡀⠀⡇⠀⠀⣿⣿⣿⡇⠀⠀⠀⠀⠀⣿⣿⣿⡇⠀⠈⡇⠀⠐⠚⠒⢒⠆⠀⠀
⠀⠀⠘⢦⡀⠀⠀⠀⠣⠀⠀⠹⠿⠿⠁⠀⠀⠀⠀⠀⠻⠿⠿⠁⠀⠰⠃⠀⠀⢀⠔⠁⠀⠀⠀
⠀⠀⠀⠀⡸⠂⠠⢲⡠⠄⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀⠀⠀⠀⠀⠔⣦⠞⠀⠀⠑⣄⠀⠀⠀⠀
⠀⠀⠀⢠⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠢⠔⠊⠉⠒⠒⠁⠀⠀⠀⠀⠀⣀⣀⣀⣀⣈⡆⠀⠀⠀
⠀⠀⠀⠈⠉⠉⠉⠉⠑⠢⡤⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⢤⠤⠒⠋⠁⠀⠉⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⢄⠀⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠓⢲⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀]],

          keys = {
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.picker.pick('smart')",
            },
            {
              icon = " ",
              key = "s",
              desc = "Search Text",
              action = ":lua Snacks.picker.pick('live_grep')",
            },
            {
              icon = " ",
              key = "n",
              desc = "New File",
              action = ":ene | startinsert",
            },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.picker.pick('files', { cwd = '" .. FLAKE .. "' })",
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

    vim.api.nvim_set_hl(0, "SnacksNormal", { link = "Normal" })
    vim.api.nvim_set_hl(0, "SnacksPicker", { link = "Normal" })
    vim.api.nvim_set_hl(0, "SnacksPickerBorder", { link = "Comment" })
  end,

  keys = {
    {
      "<leader>g",
      function()
        require("snacks").lazygit()
      end,
      desc = "git",
    },

    -- picker
    {
      "<leader>f",
      function()
        require("snacks").picker.smart()
      end,
      desc = "files",
    },

    {
      "<leader>s",
      function()
        require("snacks").picker.grep()
      end,
      desc = "search",
    },

    {
      "<leader>r",
      function()
        require("snacks").picker.commands()
      end,
      desc = "commands",
    },

    {
      "<leader>p",
      function()
        require("snacks").picker()
      end,
      desc = "pickers",
    },
  },
}
