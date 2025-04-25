return {
  {
    "blink.cmp",
    event = "InsertEnter",
    before = function()
      require("lz.n").trigger_load({
        "blink-ripgrep.nvim",
        "friendly-snippets",
      })
    end,
    after = function()
      require("blink-cmp").setup({
        keymap = {
          preset = "enter",
          ["<tab>"] = { "select_next", "snippet_forward", "fallback" },
          ["<s-tab>"] = { "select_prev", "snippet_backward", "fallback" },
        },

        completion = {
          keyword = { range = "full" },

          list = {
            selection = {
              preselect = false,
              auto_insert = true,
            }
          },

          menu = {
            draw = {
              treesitter = { "lsp" },

              columns = {
                { "label",     "label_description", gap = 1 },
                { "kind_icon", "source_name" }
              },
            },
          },

          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500
          },
        },

        appearance = {
          nerd_font_variant = "normal",
        },

        signature = { enabled = true },

        sources = {
          default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
            "ripgrep"
          },

          providers = {
            ripgrep = {
              module = "blink-ripgrep",
              name = "rg",
              score_offset = -5,
              max_items = 64,

              opts = {
                additional_paths = { blink_rg_dictionary },
                max_filesize = "128K",
              },
            },
          },
        },
      })

      vim.api.nvim_set_hl(0, 'BlinkCmpLabelMatch', {
        fg = mini_base16_palette.base0D,
        bold = true
      })
    end,
  },

  { "friendly-snippets",  lazy = true },
  { "blink-ripgrep.nvim", lazy = true },
}
