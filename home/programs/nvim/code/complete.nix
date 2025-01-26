{ inputs, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      friendly-snippets = {
        enable = true;
        autoLoad = false;
      };

      lz-n.plugins = [
        {
          __unkeyed-1 = "friendly-snippets";
          lazy = true;
        }

        {
          __unkeyed-1 = "blink-ripgrep.nvim";
          lazy = true;
        }

        {
          __unkeyed-1 = "blink-cmp-dictionary";
          lazy = true;
        }
      ];

      lsp.capabilities = # lua
        ''
          require("lz.n").trigger_load("blink.cmp")
          capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
        '';

      blink-cmp = {
        enable = true;
        lazyLoad.settings = {
          lazy = true;
          event = "InsertEnter";
          before.__raw = ''
            function()
              require("lz.n").trigger_load({
                "blink-ripgrep.nvim",
                "blink-cmp-dictionary",
                "friendly-snippets",
              })
            end
          '';
        };

        settings = {
          keymap = {
            preset = "enter";
            "<tab>" = [
              "select_next"
              "snippet_forward"
              "fallback"
            ];
            "<s-tab>" = [
              "select_prev"
              "snippet_backward"
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

            list.selection = {
              preselect = false;
              auto_insert = true;
            };

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
                max_items = 32;
                opts.max_filesize = "1M";
              };

              dictionary = {
                module = "blink-cmp-dictionary";
                name = "dict";
                min_keyword_length = 3;
                max_items = 16;
                opts.dictionary_files = [ "${pkgs.scowl}/share/dict/words.txt" ];
              };
            };
          };
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      {
        plugin = blink-ripgrep-nvim;
        optional = true;
      }

      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          pname = "blink-cmp-dictionary";
          src = inputs.blink-dict;
          version = inputs.blink-dict.shortRev;
          dependencies = [ plenary-nvim ];
        };
        optional = true;
      }
    ];

    # needed for blink-cmp-dictionary
    extraPackages = [ pkgs.wordnet ];
  };
}
