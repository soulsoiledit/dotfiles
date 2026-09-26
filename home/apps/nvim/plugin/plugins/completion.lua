safely("event:InsertEnter,CmdlineEnter", function ()
  require("blink.cmp").setup({
    keymap = {
      preset = "enter",
      ["<tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<s-Tab>"] = { "snippet_backward", "select_prev", "fallback" }
    },
    completion = {
      keyword = { range = "full" },
      list = { selection = { preselect = false } },
      menu = { draw = { align_to = "kind_icon" } },
      documentation = { auto_show = true }
    },
    signature = { enabled = true },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
      providers = {
        ripgrep = {
          module = "blink-ripgrep",
          name = "rg",
          score_offset = -6,
          opts = {
            backend = {
              ripgrep = {
                additional_paths = { nix.dictionary },
                max_filesize = "128K"
              }
            }
          }
        }
      }
    }
  })
end)
