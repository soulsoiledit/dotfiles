local nmap = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

now_if_args(function()
  vim.cmd.packadd("nvim-treesitter")
  require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
  })
end)

later(function()
  vim.cmd.packadd("noice.nvim")
  require("noice").setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
      signature = { enabled = false },
    },
    presets = {
      long_message_to_split = true,
      command_palette = true,
      bottom_search = true,
    },
  })
end)

later(function()
  vim.cmd.packadd("lualine.nvim")
  local auto = require("lualine.themes.auto")
  auto.normal.a.bg = nixpalette.base0D
  auto.normal.b.fg = nixpalette.base0D
  require("lualine").setup({
    options = {
      theme = auto,
      disabled_filetypes = { "snacks_dashboard" },
    },
  })
end)

later(function()
  vim.cmd.packadd("bufferline.nvim")
  local bufferline = require("bufferline")
  bufferline.setup({
    options = {
      tab_size = 4,
      diagnostics = "nvim_lsp",
    },
  })

  nmap("<tab>", function()
    bufferline.cycle(1)
  end, "bnext")
  nmap("<s-tab>", function()
    bufferline.cycle(-1)
  end, "bprevious")
  nmap("<c-tab>", function()
    bufferline.move(1)
  end, "move buffer right")
  nmap("<c-s-tab>", function()
    bufferline.move(-1)
  end, "move buffer left")
end)
