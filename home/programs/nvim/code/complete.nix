{ inputs, pkgs, ... }:

{
  programs.nixvim.plugins = {
    blink-cmp = {
      enable = true;
      lazyLoad.settings = {
        lazy = true;
        event = "InsertEnter";
        before.__raw = ''
          function()
            require("lz.n").trigger_load({
              "blink-ripgrep.nvim",
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
          ];

          providers = {
            ripgrep = {
              module = "blink-ripgrep";
              name = "rg";
              max_items = 128;
              opts = {
                max_filesize = "128K";
                additional_paths = [
                  "${pkgs.scowl}/share/dict/words.txt"
                ];
              };
            };
          };
        };
      };
    };

    friendly-snippets = {
      enable = true;
      autoLoad = false;
    };

    blink-ripgrep = {
      enable = true;
      package = pkgs.vimPlugins.blink-ripgrep-nvim.overrideAttrs {
        src = inputs.blink-ripgrep;
      };
      lazyLoad.settings = {
        __unkeyed-1 = "blink-ripgrep.nvim";
        lazy = true;
      };
    };

    lz-n.plugins = [
      {
        __unkeyed-1 = "friendly-snippets";
        lazy = true;
      }
    ];
  };
}
