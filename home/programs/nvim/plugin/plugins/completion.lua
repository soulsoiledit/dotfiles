later(function()
  vim.cmd.packadd("blink.cmp")
  vim.cmd.packadd("blink-ripgrep.nvim")
  vim.cmd.packadd("friendly-snippets")

  require("blink-cmp").setup({
    keymap = {
      preset = "enter",
      ["<tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<s-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
    },

    completion = {
      keyword = { range = "full" },
      list = { selection = { preselect = false } },

      menu = {
        draw = {
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

    appearance = { nerd_font_variant = "normal" },

    signature = { enabled = true },

    sources = {
      default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
      providers = {
        ripgrep = {
          module = "blink-ripgrep",
          name = "rg",
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

  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", {
    fg = nixpalette.base0D,
    bold = true,
  })
end)
