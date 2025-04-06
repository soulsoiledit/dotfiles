return {
  {
    "mini.nvim",
    after = function()
      require("mini.basics").setup({
        mappings = { windows = true },
        options = { extra_ui = true }
      })

      icons = require("mini.icons")
      icons.setup()
      icons.mock_nvim_web_devicons()

      misc = require("mini.misc")
      misc.setup()
      misc.setup_restore_cursor()
      misc.setup_auto_root({ ".git", ".root" })
    end
  },

  {
    "mini.pairs",
    event = "InsertEnter",
    after = function()
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
    end,
  },

  {
    "mini.surround",
    event = "InsertEnter",
    after = function()
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
    end
  },
}
