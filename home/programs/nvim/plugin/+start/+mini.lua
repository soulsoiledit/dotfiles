later = require("mini.deps").later

require("mini.basics").setup({
  mappings = { windows = true },
  options = { extra_ui = true },
})

local misc = require("mini.misc")
misc.setup()
misc.setup_restore_cursor()
misc.setup_auto_root({ ".git", ".root" })

nixpalette = require("nixpalette")
require("mini.base16").setup({
  palette = nixpalette,
})

hl(0, "Search", {
  bg = nixpalette.base0D,
  fg = nixpalette.base01,
})
hl(0, "CurSearch", {
  bg = nixpalette.base0F,
  fg = nixpalette.base01,
})

hl(0, "markdownH1", { fg = nixpalette.base08 })
hl(0, "markdownH2", { fg = nixpalette.base09 })
hl(0, "markdownH3", { fg = nixpalette.base0A })
hl(0, "markdownH4", { fg = nixpalette.base0B })
hl(0, "markdownH5", { fg = nixpalette.base0C })
hl(0, "markdownH6", { fg = nixpalette.base0D })

later(function()
  require("mini.icons").setup()
  require("mini.icons").mock_nvim_web_devicons()

  require("mini.pairs").setup({
    mappings = {
      ['"'] = { neigh_pattern = "[^%w][^%w]" },
      ["'"] = { neigh_pattern = "[^%w][^%w]" },
      ["("] = { neigh_pattern = "[^\\][%s%)%]%}]" },
      ["["] = { neigh_pattern = "[^\\][%s%)%]%}]" },
      ["`"] = { neigh_pattern = "[^%w][^%w]" },
      ["{"] = { neigh_pattern = "[^\\][%s%)%]%}]" },
    },
  })

  require("mini.surround").setup({
    mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
    },
  })

  local trailspace = require("mini.trailspace")
  trailspace.setup()
  autocmd("BufWritePre", {
    callback = function(_ev)
      trailspace.trim()
      trailspace.trim_last_lines()
    end,
  })

  require("mini.cursorword").setup()
  require("mini.diff").setup({
    view = { style = "sign" },
  })
end)
