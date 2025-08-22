later(function()
  vim.cmd("packadd lualine.nvim")

  local auto = require("lualine.themes.auto")
  auto.normal.a.bg = nixpalette.base0D
  auto.normal.b.fg = nixpalette.base0D
  require("lualine").setup({
    options = {
      theme = auto,
      disabled_filetypes = { "snacks_dashboard" },
    },
  })

  vim.cmd("packadd bufferline.nvim")
  local bufferline = require("bufferline")
  bufferline.setup({
    options = {
      tab_size = 4,
      diagnostics = "nvim_lsp",
    },
  })

  keymap("n", "<tab>", function()
    bufferline.cycle(1)
  end, { desc = "bnext" })

  keymap("n", "<s-tab>", function()
    bufferline.cycle(-1)
  end, { desc = "bprevious" })

  keymap("n", "<c-tab>", function()
    bufferline.move(1)
  end, { desc = "move buffer right" })

  keymap("n", "<c-s-tab>", function()
    bufferline.move(-1)
  end, { desc = "move buffer left" })
end)
