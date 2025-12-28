now(function()
  require("mini.base16").setup({
    palette = nixpalette,
  })

  vim.api.nvim_set_hl(0, "Search", { bg = nixpalette.base0D, fg = nixpalette.base01 })
  vim.api.nvim_set_hl(0, "CurSearch", { bg = nixpalette.base0F, fg = nixpalette.base01 })

  vim.api.nvim_set_hl(0, "markdownH1", { fg = nixpalette.base08 })
  vim.api.nvim_set_hl(0, "markdownH2", { fg = nixpalette.base09 })
  vim.api.nvim_set_hl(0, "markdownH3", { fg = nixpalette.base0A })
  vim.api.nvim_set_hl(0, "markdownH4", { fg = nixpalette.base0B })
  vim.api.nvim_set_hl(0, "markdownH5", { fg = nixpalette.base0C })
  vim.api.nvim_set_hl(0, "markdownH6", { fg = nixpalette.base0D })
end)

now(function()
  require("mini.basics").setup({
    mappings = { windows = true },
    options = { extra_ui = true },
  })
end)

now_if_args(function()
  local misc = require("mini.misc")
  misc.setup()
  misc.setup_restore_cursor()
  misc.setup_auto_root({ ".git", ".root" })
end)

now(function()
  require("mini.icons").setup()
  later(require("mini.icons").mock_nvim_web_devicons)
  later(require("mini.icons").tweak_lsp_kind)
end)

later(function()
  local trailspace = require("mini.trailspace")
  trailspace.setup()
  vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(_ev)
      trailspace.trim()
      trailspace.trim_last_lines()
    end,
  })
end)

later(function()
  require("mini.diff").setup({
    view = { style = "sign" },
  })
end)
