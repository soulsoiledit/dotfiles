{ inputs, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      blink-cmp = {
        enable = true;
        luaConfig.pre = # lua
          ''
            require('blink.compat').setup({
              impersonate_nvim_cmp = true,
            })
          '';
        settings = {
          keymap = {
            preset = "enter";
            "<Tab>" = [
              "select_next"
              "snippet_forward"
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "snippet_backward"
              "fallback"
            ];
          };

          appearance.use_nvim_cmp_as_default = true;

          completion.documentation = {
            auto_show = true;
            auto_show_delay_ms = 50;
          };

          # add calc and latex sources
          sources = {
            completion.enabled_providers = [
              "lsp"
              "path"
              "snippets"
              "buffer"
              "calc"
              "latex_symbols"
            ];
            providers = {
              calc = {
                name = "calc";
                module = "blink.compat.source";
              };
              latex_symbols = {
                name = "latex_symbols";
                module = "blink.compat.source";
                opts = {
                  strategy = 2;
                };
              };
            };
          };
        };
      };

      friendly-snippets.enable = true;

      cmp-calc.enable = true;
      cmp-latex-symbols.enable = true;

      # extend lsp capabilities
      lsp.capabilities = # lua
        ''
          capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
        '';
    };

    # TODO: use blink.compat package and module when added
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        pname = "blink.compat";
        version = inputs.blink-compat.shortRev;
        src = inputs.blink-compat;
        meta.homepage = "https://github.com/Saghen/blink.compat";
      })
    ];
  };
}
