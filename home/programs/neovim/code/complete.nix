{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      friendly-snippets.enable = true;

      cmp-dictionary.enable = true;

      lsp.capabilities = # lua
        ''
          capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
        '';

      blink-compat.enable = true;

      blink-cmp = {
        enable = true;
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
      pkgs.vimPlugins.blink-ripgrep-nvim
    ];
  };
}
