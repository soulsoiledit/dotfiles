{ config, ... }:

{
  programs.nixvim = {
    diagnostics = {
      virtual_text.prefix = "●";
      severity_sort = true;
      signs.text = config.lib.nixvim.toRawKeys {
        "vim.diagnostic.severity.ERROR" = " ";
        "vim.diagnostic.severity.WARN" = " ";
        "vim.diagnostic.severity.HINT" = " ";
        "vim.diagnostic.severity.INFO" = " ";
      };
    };

    plugins = {
      nvim-lightbulb = {
        enable = true;
        lazyLoad.settings.event = "DeferredUIEnter";
      };

      # formatting
      lsp-format = {
        enable = true;
        lazyLoad.settings.lazy = true;
      };

      efmls-configs.enable = true;

      lsp = {
        enable = true;
        lazyLoad.settings = {
          before = # lua
            ''
              function()
                require("lz.n").trigger_load("lsp-format.nvim")
              end
            '';
          event = [
            "BufNewFile"
            "BufReadPost"
          ];
          before.__raw = ''
            function()
              require("lz.n").trigger_load("lsp-format.nvim")
            end
          '';
        };

        inlayHints = true;

        keymaps.lspBuf = {
          gd = "definition";
          gD = "declaration";
          gri = "implementation";
          grt = "type_definition";
          grr = "references";
          grn = "rename";
          gra = "code_action";
        };
      };
    };
  };
}
