safely("now", function()
  require("markview").setup()
  vim.api.nvim_set_hl(0, "MarkviewListItemMinus", { link = "MarkviewPalette6Fg" })
  vim.api.nvim_set_hl(0, "MarkviewListItemStar", { link = "MarkviewPalette2Fg" })
end)

safely_if_args("now", "later", function()
  vim.cmd.packadd("nvim-treesitter")
  local treesitter = vim.api.nvim_create_augroup("treesitter.setup", {})
  vim.api.nvim_create_autocmd("FileType", {
    group = treesitter,
    callback = function(event)
      local buf, filetype = event.buf, event.match
      local language = vim.treesitter.language.get_lang(filetype) or filetype
      if not vim.treesitter.language.add(language) then
        return
      end
      vim.treesitter.start(buf, language)
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end)

safely("later", function()
  local ui2 = require("vim._core.ui2")
  ui2.enable({
    enable = true,
    msg = { targets = "msg" },
  })

  -- limits width to handle bad lsp responses
  local set_pos = ui2.msg.set_pos
  ui2.msg.set_pos = function(tgt)
    set_pos(tgt)
    pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
      width = math.max(25, vim.o.columns - 85),
    })
  end
end)

safely("later", function()
  vim.cmd.packadd("bufferline.nvim")
  local bufferline = require("bufferline")
  bufferline.setup({
    options = {
      tab_size = 4,
      diagnostics = "nvim_lsp",
      custom_areas = {
        right = function()
          local mode = vim.api.nvim_get_mode()
          return {
            { text = mode.mode },
          }
        end,
      },
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

safely("later", function()
  require("blink.pairs").setup({
    highlights = {
      groups = {
        "RainbowDelimiterRed",
        "RainbowDelimiterOrange",
        "RainbowDelimiterYellow",
        "RainbowDelimiterGreen",
        "RainbowDelimiterCyan",
        "RainbowDelimiterBlue",
        "RainbowDelimiterViolet",
      },
    },
  })
end)

safely("later", function()
  require("colorizer").setup({
    options = {
      parsers = {
        css = true,
        tailwind = {
          enable = true,
          lsp = { enable = false },
        },
      },
    },
  })
end)

safely("later", function()
  require("nvim-lightbulb").setup({
    autocmd = { enabled = true },
    sign = {
      text = "",
      lens_text = "",
    },
  })
end)

safely("later", function()
  vim.cmd.packadd("which-key.nvim")
  require("which-key").setup({
    win = { height = { min = 5, max = 10 } },
    spec = {
      { "gr", group = "refactor" },
      { "gra", desc = "code action" },
      { "gri", desc = "implementation" },
      { "grn", desc = "rename" },
      { "grr", desc = "reference" },
      { "grt", desc = "type definition" },
    },
  })
end)
