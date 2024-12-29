{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      friendly-snippets = {
        enable = true;
        autoLoad = false;
      };

      cmp-dictionary = {
        enable = true;
        autoLoad = false;
      };

      lz-n.plugins = [
        {
          __unkeyed-1 = "friendly-snippets";
          lazy = true;
        }
        {
          __unkeyed-1 = "cmp-dictionary";
          lazy = true;
          after.__raw = ''
            function()
              require("cmp_dictionary").setup({
                paths = { "${pkgs.scowl}/share/dict/words.txt" },
              })
            end
          '';
        }
        {
          __unkeyed-1 = "blink-ripgrep.nvim";
          lazy = true;
        }
      ];

      lsp.capabilities = # lua
        ''
          require("lz.n").trigger_load("blink.cmp")
          capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
        '';

      blink-compat = {
        enable = true;
        lazyLoad.settings = {
          lazy = true;
          before.__raw = ''
            function()
              require("lz.n").trigger_load("cmp-dictionary")
            end
          '';
        };
      };

      blink-cmp = {
        enable = true;
        lazyLoad.settings = {
          lazy = true;
          event = "InsertEnter";
          before.__raw = ''
            function()
              require("lz.n").trigger_load({
                "blink-ripgrep.nvim",
                "blink.compat",
                "friendly-snippets",
              })
            end
          '';
        };

        settings = {
          keymap = {
            preset = "super-tab";
            "<tab>" = {
              __unkeyed-1.__raw = ''
                function(cmp)
                  if cmp.snippet_active() then
                    return cmp.accept()
                  else
                    return cmp.select_next()
                  end
                end
              '';
              __unkeyed-2 = "snippet_forward";
              __unkeyed-3 = "fallback";
            };
            "<s-tab>" = [
              "select_prev"
              "snippet_forward"
              "fallback"
            ];
          };

          appearance = {
            use_nvim_cmp_as_default = true;
            nerd_font_variant = "normal";
          };

          completion = {
            accept.auto_brackets.enabled = false;

            keyword.range = "full";

            list.selection = "auto_insert";

            menu.draw = {
              columns = [
                {
                  __unkeyed-1 = "label";
                  __unkeyed-2 = "label_description";
                  gap = 1;
                }
                [
                  "kind_icon"
                  "source_name"
                ]
              ];
              treesitter = [ "lsp" ];
            };

            documentation = {
              auto_show = true;
              auto_show_delay_ms = 500;
            };
          };

          signature.enabled = true;

          sources = {
            default = [
              "lsp"
              "path"
              "snippets"
              "buffer"
              "ripgrep"
              "dictionary"
            ];

            providers = {
              ripgrep = {
                module = "blink-ripgrep";
                name = "rg";
                score_offset = -4;
                opts.max_filesize = "1M";
              };
              dictionary = {
                name = "dictionary";
                module = "blink.compat.source";
                score_offset = -16;
                opts.max_number_items = 16;
              };
            };
          };
        };
      };
    };

    extraPlugins = [
      {
        plugin = pkgs.vimPlugins.blink-ripgrep-nvim;
        optional = true;
      }
    ];
  };
}
