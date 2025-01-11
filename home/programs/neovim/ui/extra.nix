{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      which-key = {
        enable = true;
        lazyLoad.settings.event = "DeferredUIEnter";
        settings.spec = [
          {
            __unkeyed-1 = "<leader>w";
            proxy = "<c-w>";
          }
        ];
      };

      lz-n.plugins = [
        {
          __unkeyed-1 = "rainbow-delimiters.nvim";
          event = "DeferredUIEnter";

          # rerun attach
          after.__raw = ''
            function()
              vim.cmd("doautoall TSRainbowDelimits FileType")
            end
          '';
        }
      ];

      ccc = {
        enable = true;
        lazyLoad.settings.event = "DeferredUIEnter";

        settings = {
          lsp = false;
          highlighter.auto_enable = true;
        };

        # rerun auto_enable autocmd
        luaConfig.post = ''
          vim.api.nvim_exec_autocmds(
            "BufEnter",
            { group = "ccc-highlighter-auto-enable" }
          )
        '';
      };

      snacks.settings.indent = {
        enabled = true;
        indent.enabled = false;
        scope.hl = "Comment";
      };

      mini = {
        luaConfig.pre = "vim.g.minitrailspace_disable = true";
        modules = {
          cursorword = { };
          trailspace = { };
        };
      };
    };

    # enable trailspace on real buffers
    autoCmd = [
      {
        event = "BufNew";
        callback.__raw = ''
          function(args)
            vim.g.minitrailspace_disable = false
          end
        '';
      }
    ];

    extraPlugins = [
      {
        plugin = pkgs.vimPlugins.rainbow-delimiters-nvim;
        optional = true;
      }
    ];
  };
}
