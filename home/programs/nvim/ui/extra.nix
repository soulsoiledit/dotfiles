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

      colorizer = {
        enable = true;
        lazyLoad.settings.event = "DeferredUIEnter";
        settings = {
          lazy_load = true;
          user_commands = true;
          user_default_options = {
            css = true;
            tailwind = "lsp";
            sass = {
              enable = true;
              parsers = [ "css" ];
            };
          };
        };
      };

      snacks.settings.indent = {
        enabled = true;
        indent.enabled = false;
        scope.hl = "Comment";
      };

      mini = {
        luaConfig.pre = "vim.b.minitrailspace_disable = true";
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
            vim.b[args.buf].minitrailspace_disable = false
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
