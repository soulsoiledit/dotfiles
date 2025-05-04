return {
  {
    "mini.nvim",
    after = function()
      require("mini.basics").setup({
        mappings = { windows = true },
        options = { extra_ui = true }
      })

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
          find = "",
          find_left = "",
          highlight = "",
          replace = "gsc",
          update_n_lines = "",
        },
      })

      local misc = require("mini.misc")
      misc.setup()
      misc.setup_restore_cursor()
      misc.setup_auto_root({ ".git", ".root" })

      local icons = require("mini.icons")
      icons.setup()
      icons.mock_nvim_web_devicons()

      require("mini.base16").setup({
        palette = mini_base16_palette,
      })

      local hl = vim.api.nvim_set_hl
      hl(0, "Search", {
        bg = mini_base16_palette.base0D,
        fg = mini_base16_palette.base01
      })
      hl(0, "CurSearch", {
        bg = mini_base16_palette.base0F,
        fg = mini_base16_palette.base01
      })

      hl(0, "markdownH1", { fg = mini_base16_palette.base08 })
      hl(0, "markdownH2", { fg = mini_base16_palette.base09 })
      hl(0, "markdownH3", { fg = mini_base16_palette.base0A })
      hl(0, "markdownH4", { fg = mini_base16_palette.base0B })
      hl(0, "markdownH5", { fg = mini_base16_palette.base0C })
      hl(0, "markdownH6", { fg = mini_base16_palette.base0D })

      require("mini.cursorword").setup()
      vim.schedule(require("mini.trailspace").setup)
      require("mini.diff").setup({
        view = { style = "sign", },
      })
    end
  },
}
