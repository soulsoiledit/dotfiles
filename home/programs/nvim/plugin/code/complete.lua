later(function()
  vim.cmd("packadd blink.cmp")
  vim.cmd("packadd blink-ripgrep.nvim")
  vim.cmd("packadd friendly-snippets")

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
        },
      },

      menu = {
        draw = {
          treesitter = { "lsp" },

          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "source_name" },
          },
        },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
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
        "ripgrep",
      },

      providers = {
        ripgrep = {
          module = "blink-ripgrep",
          name = "rg",
          score_offset = -5,
          max_items = 64,

          opts = {
            backend = {
              ripgrep = {
                additional_paths = { vim.fs.normalize("$XDG_DATA_HOME/dict/words") },
                max_filesize = "128K",
              },
            },
          },
        },
      },
    },
  })

  hl(0, "BlinkCmpLabelMatch", {
    fg = nixpalette.base0D,
    bold = true,
  })
end)
