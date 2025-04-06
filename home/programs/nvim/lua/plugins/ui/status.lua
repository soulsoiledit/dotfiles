return {
  {
    "lualine.nvim",
    event = "DeferredUIEnter",
    after = function()
      local auto = require("lualine.themes.auto")
      local color = mini_base16_palette.base0D
      auto.normal.a.bg = color
      auto.normal.b.fg = color

      require("lualine").setup({
        options = {
          theme = auto,
          disabled_filetypes = { "snacks_dashboard" },
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
      {
        "<tab>",
        "<cmd>BufferLineCycleNext<cr>",
        desc = "next buffer",
      },

      {
        "<s-tab>",
        "<cmd>BufferLineCyclePrev<cr>",
        desc = "prev buffer",
      },

      {
        "<c-tab>",
        "<cmd>BufferLineMoveNext<cr>",
        desc = "move buffer right",
      },

      {
        "<c-s-tab>",
        "<cmd>BufferLineMovePrev<cr>",
        desc = "move buffer left",
      }
    }
  },
}
