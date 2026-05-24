safely("now", function ()
  require("mini.basics").setup({
    options = { extra_ui = true }
  })

  require("mini.base16").setup({
    palette = nix.palette
  })

  vim.api.nvim_set_hl(0, "Search", { bg = nix.palette.base0D, update = true })
  vim.api.nvim_set_hl(0, "CurSearch", { bg = nix.palette.base0F, update = true })

  vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", { link = "MiniTablineCurrent" })
  vim.api.nvim_set_hl(0, "MiniTablineModifiedVisible", { link = "MiniTablineVisible" })
  vim.api.nvim_set_hl(0, "MiniTablineModifiedHidden", { link = "MiniTablineHidden" })

  vim.api.nvim_set_hl(0, "markdownH1", { fg = nix.palette.base08 })
  vim.api.nvim_set_hl(0, "markdownH2", { fg = nix.palette.base09 })
  vim.api.nvim_set_hl(0, "markdownH3", { fg = nix.palette.base0A })
  vim.api.nvim_set_hl(0, "markdownH4", { fg = nix.palette.base0B })
  vim.api.nvim_set_hl(0, "markdownH5", { fg = nix.palette.base0C })
  vim.api.nvim_set_hl(0, "markdownH6", { fg = nix.palette.base0D })

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

  require("mini.diff").setup({
    view = { style = "sign" }
  })
end)
