safely("now", function()
  require("mini.base16").setup({
    palette = nix.palette,
  })

  vim.api.nvim_set_hl(0, "Search", { bg = nix.palette.base0D, fg = nix.palette.base01 })
  vim.api.nvim_set_hl(0, "CurSearch", { bg = nix.palette.base0F, fg = nix.palette.base01 })

  vim.api.nvim_set_hl(0, "markdownH1", { fg = nix.palette.base08 })
  vim.api.nvim_set_hl(0, "markdownH2", { fg = nix.palette.base09 })
  vim.api.nvim_set_hl(0, "markdownH3", { fg = nix.palette.base0A })
  vim.api.nvim_set_hl(0, "markdownH4", { fg = nix.palette.base0B })
  vim.api.nvim_set_hl(0, "markdownH5", { fg = nix.palette.base0C })
  vim.api.nvim_set_hl(0, "markdownH6", { fg = nix.palette.base0D })
end)

safely("now", function()
  require("mini.basics").setup({
    mappings = { windows = true },
    options = { extra_ui = true },
  })
end)

safely_if_args("now", "later", function()
  misc.setup_restore_cursor()
  misc.setup_auto_root({ ".git", ".root" })
end)

safely("now", function()
  require("mini.icons").setup()
  safely("later", require("mini.icons").mock_nvim_web_devicons)
  safely("later", require("mini.icons").tweak_lsp_kind)
end)

safely("event:UIEnter", function()
  local trailspace = require("mini.trailspace")
  trailspace.setup()
  vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(_ev)
      trailspace.trim()
      trailspace.trim_last_lines()
    end,
  })
end)

safely("event:UIEnter", function()
  require("mini.diff").setup({
    view = { style = "sign" },
  })
end)
