safely("now", function ()
  require("markview").setup()
  vim.api.nvim_set_hl(0, "MarkviewListItemMinus", { link = "MarkviewPalette6Fg" })
  vim.api.nvim_set_hl(0, "MarkviewListItemStar", { link = "MarkviewPalette2Fg" })
end)

safely_if_args("now", "later", function ()
  vim.cmd.packadd("nvim-treesitter")
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
      width = math.max(25, vim.o.columns - 85)
    })
  end
end)

safely("later", function ()
  -- add modified sign to buffer
  local tabline = require("mini.tabline")
  tabline.setup({
    format = function (buf_id, label)
      local icon = require("mini.icons").get("file", vim.api.nvim_buf_get_name(buf_id)) or ""
      local modified = vim.bo[buf_id].modified and "+" or ""
      return string.format(" %s %s%s ", icon, label, modified)
    end
  })

  local function mode()
    local current_mode = vim.fn.mode()
    local modemap = {
      n = "MiniStatuslineModeInsert",
      v = "MiniStatuslineModeReplace",
      V = "MiniStatuslineModeReplace",
      ["\22"] = "MiniStatuslineModeReplace",
      i = "MiniStatuslineModeVisual",
      R = "MiniStatuslineModeNormal",
      c = "MiniStatuslineModeCommand"
    }
    local hl = modemap[current_mode] or "MiniStatuslineModeOther"
    return string.format("%%#%s# %s ", hl, current_mode)
  end

  local function diagnostics()
    local diags = vim.diagnostic.get(0)
    if #diags == 0 then return "" end

    local config = vim.diagnostic.config()

    local counts = {}
    for _, diag in ipairs(diags) do
      counts[diag.severity] = (counts[diag.severity] or 0) + 1
    end

    local t = {}
    for idx, count in pairs(counts) do
      if config and config.signs and config.signs.text then
        local sign = config.signs.text[idx] or ""
        local hl = "Diagnostic" .. vim.diagnostic.severity[idx]
        local hl_diag = string.format("%%#%s#%s %d%%*", hl, sign, count)
        table.insert(t, hl_diag)
      end
    end

    return table.concat(t, " ")
  end

  -- put it all together
  STabline = function ()
    local buffers = tabline.make_tabline_string()
    return buffers .. "%=" .. diagnostics() .. " " .. mode()
  end

  -- keep diagnostic and mode components updated
  vim.api.nvim_create_autocmd({ "ModeChanged", "DiagnosticChanged" }, {
    group = vim.api.nvim_create_augroup("tabline.sync", {}),
    pattern = "*",
    callback = function ()
      vim.cmd.redrawtabline()
    end
  })

  vim.opt.laststatus = 0
  vim.opt.tabline = "%!v:lua.STabline()"
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
  vim.cmd.packadd("which-key.nvim")
  require("which-key").setup({
    win = { height = { min = 5, max = 10 } },
    spec = {
      { "gr", group = "refactor" },
      { "gra", desc = "code action" },
      { "gri", desc = "implementation" },
      { "grn", desc = "rename" },
      { "grr", desc = "reference" },
      { "grt", desc = "type definition" }
    }
  })
end)
