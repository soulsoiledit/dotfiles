safely("now", function ()
  require("mini.basics").setup({
    options = { extra_ui = true }
  })

  vim.api.nvim_set_hl(0, "Search", { bg = theme.base0D, update = true })
  vim.api.nvim_set_hl(0, "CurSearch", { bg = theme.base0F, update = true })

  vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", { link = "MiniTablineCurrent" })
  vim.api.nvim_set_hl(0, "MiniTablineModifiedVisible", { link = "MiniTablineVisible" })
  vim.api.nvim_set_hl(0, "MiniTablineModifiedHidden", { link = "MiniTablineHidden" })

  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = theme.base0E, update = true })

  vim.api.nvim_set_hl(0, "markdownH1", { fg = theme.base08 })
  vim.api.nvim_set_hl(0, "markdownH2", { fg = theme.base09 })
  vim.api.nvim_set_hl(0, "markdownH3", { fg = theme.base0A })
  vim.api.nvim_set_hl(0, "markdownH4", { fg = theme.base0B })
  vim.api.nvim_set_hl(0, "markdownH5", { fg = theme.base0C })
  vim.api.nvim_set_hl(0, "markdownH6", { fg = theme.base0D })

  require("mini.icons").setup()
  safely("later", require("mini.icons").mock_nvim_web_devicons)
end)

safely_if_args("now", "later", function ()
  misc.setup_restore_cursor()
  misc.setup_auto_root()

  local trailspace = require("mini.trailspace")
  trailspace.setup()
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("trailspace.trim", {}),
    callback = function ()
      trailspace.trim()
      trailspace.trim_last_lines()
    end
  })

  local input = require("mini.input")
  input.setup({
    handlers = {
      view = input.gen_view.floatwin({ style = "TL" })
    }
  })

  require("mini.diff").setup({
    view = { style = "sign" }
  })
end)
