return {
  {
    "nvim-treesitter",
    event = "DeferredUIEnter",
    after = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  {
    "lualine.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("lualine").setup({
        options = {
          disabled_filetypes = { "snacks_dashboard" }
        }
      })
    end,
  },

  {
    "bufferline.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("bufferline").setup({
        options = {
          tab_size = 4,
          diagnostics = "nvim_lsp",
        }
      })
    end,
    keys = {
      { "<tab>",     "<cmd>BufferLineCycleNext<cr>", desc = "next buffer", },
      { "<s-tab>",   "<cmd>BufferLineCyclePrev<cr>", desc = "prev buffer", },
      { "<c-tab>",   "<cmd>BufferLineMoveNext<cr>",  desc = "move buffer right", },
      { "<c-s-tab>", "<cmd>BufferLineMovePrev<cr>",  desc = "move buffer left", }
    }
  },

  {
    "noice.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
          signature = { enabled = false },
        },
        presets = {
          long_message_to_split = true,
          command_palette = true,
          bottom_search = true,
        },
      })
    end,
  },

  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("which-key").setup({
        spec = {
          { "gra",       desc = "code action" },
          { "gri",       desc = "goto imp" },
          { "grn",       desc = "rename" },
          { "grr",       desc = "goto ref" },

          { "<leader>w", proxy = "<c-w>" },
        }
      })
    end,
  },

  {
    "rainbow-delimiters.nvim",
    event = "DeferredUIEnter",
    after = function()
      vim.cmd("doautoall TSRainbowDelimits FileType")
    end,
  },

  {
    "nvim-colorizer.lua",
    event = "DeferredUIEnter",
    after = function()
      require("colorizer").setup({
        lazy_load = true,
        user_commands = true,
        user_default_options = {
          AARRGGBB = true,
          css = true,
          tailwind = "lsp"
        },
      })
    end,
  },

  {
    "nvim-lightbulb",
    event = "DeferredUIEnter",
    after = function()
      require("nvim-lightbulb").setup()
    end,
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
