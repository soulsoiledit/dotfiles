return {
  {
    "mini.nvim",
    after = function()
      icons = require("mini.icons")
      icons.setup()
      icons.mock_nvim_web_devicons()

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

      misc = require("mini.misc")
      misc.setup()
      misc.setup_restore_cursor()
      misc.setup_auto_root({ ".git", ".root" })
    end
  },

  {
    "mini.cursorword",
    event = "DeferredUIEnter",
    after = function()
      require("mini.cursorword").setup()
    end,
  },

  {
    "mini.trailspace",
    event = "DeferredUIEnter",
    after = function()
      require("mini.trailspace").setup()
    end
  },

  {
    "mini.diff",
    event = "DeferredUIEnter",
    after = function()
      require("mini.diff").setup({
        view = { style = "sign" }
      })
    end
  }
}
