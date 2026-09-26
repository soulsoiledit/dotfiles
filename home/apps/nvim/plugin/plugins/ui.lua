safely("now", function ()
  require("markview").setup()
  vim.api.nvim_set_hl(0, "MarkviewListItemMinus", { link = "MarkviewPalette6Fg" })
  vim.api.nvim_set_hl(0, "MarkviewListItemStar", { link = "MarkviewPalette2Fg" })
end)

safely_if_args("now", "later", function ()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter.setup", {}),
    callback = function (event)
      local buf, filetype = event.buf, event.match
      local language = vim.treesitter.language.get_lang(filetype) or filetype
      if not vim.treesitter.language.add(language) then
        return
      end
      vim.treesitter.start(buf, language)
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  })
end)

safely("later", function ()
  local ui2 = require("vim._core.ui2")
  ui2.enable({
    enable = true,
    msg = { targets = "msg" }
  })

  -- limits width to handle bad lsp responses
  local set_pos = ui2.msg.set_pos
  ui2.msg.set_pos = function (tgt)
    set_pos(tgt)
    pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
      width = math.floor(vim.o.columns * 3 / 10)
    })
  end
end)

safely("later", function ()
  local diag_config = vim.diagnostic.config()
  local text_signs = diag_config and diag_config.signs and diag_config.signs.text or {}
  local diag_signs = vim.iter(pairs(vim.diagnostic.severity))
    :fold({}, function (acc, name, id)
      if type(name) == "string" and name:len() > 1 then
        acc[name] = string.format("%%#Diagnostic%s#%s ", name, text_signs[id])
      end
      return acc
    end)

  local statusline = require("mini.statusline")
  statusline.setup({
    content = {
      active = function ()
        local mode, mode_hl = statusline.section_mode({
          trunc_width = vim.o.columns + 1
        })
        local diagnostics = statusline.section_diagnostics({
          icon = "",
          signs = diag_signs,
          trunc_width = nil
        })

        return statusline.combine_groups({
          { strings = { diagnostics } },
          "%<",
          { hl = mode_hl, strings = { mode } }
        })
      end
    }
  })

  -- add modified sign to buffer
  local tabline = require("mini.tabline")
  tabline.setup({
    format = function (buf_id, label)
      local modified = vim.bo[buf_id].modified and "+" or ""
      return tabline.default_format(buf_id, label) .. modified
    end
  })

  -- put it all together
  _G.STabline = function ()
    return tabline.make_tabline_string() .. "%=" .. statusline.active()
  end

  -- keep status components updated
  vim.api.nvim_create_autocmd({ "ModeChanged", "DiagnosticChanged" }, {
    group = vim.api.nvim_create_augroup("tabline.sync", {}),
    pattern = "*",
    callback = function ()
      vim.cmd.redrawtabline()
    end
  })

  vim.o.laststatus = 0
  vim.o.tabline = "%!v:lua.STabline()"
end)

safely("later", function ()
  require("blink.pairs").setup({
    highlights = {
      groups = {
        "RainbowDelimiterRed",
        "RainbowDelimiterOrange",
        "RainbowDelimiterYellow",
        "RainbowDelimiterGreen",
        "RainbowDelimiterCyan",
        "RainbowDelimiterBlue",
        "RainbowDelimiterViolet"
      }
    }
  })
end)

safely("later", function ()
  require("colorizer").setup({
    options = {
      parsers = {
        css = true,
        tailwind = {
          enable = true,
          lsp = { enable = false }
        }
      }
    }
  })
end)

safely_if_args("now", "later", function ()
  require("nvim-lightbulb").setup({
    autocmd = { enabled = true },
    sign = {
      text = "",
      lens_text = ""
    }
  })
end)

safely("later", function ()
  require("which-key").setup({
    win = { no_overlap = false },
    layout = { width = math.floor(vim.o.columns / 4 - 3) },
    spec = {
      { "gr", group = "refactor" }
    }
  })
end)
