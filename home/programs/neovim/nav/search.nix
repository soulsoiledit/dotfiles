{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      grug-far = {
        enable = true;
        lazyLoad.settings.cmd = "GrugFar";
      };

      telescope = {
        enable = true;
        enabledExtensions = [ "fzf" ];

        lazyLoad.settings = {
          lazy = true;
          before.__raw = ''
            function()
              require("lz.n").trigger_load("telescope-fzf-native.nvim")
            end
          '';

          cmd = "Telescope";
          keys = [
            # files
            {
              __unkeyed-1 = "<leader>f";
              __unkeyed-2 = "<cmd>Telescope find_files<cr>";
              desc = "files";
            }

            {
              __unkeyed-1 = "<leader>b";
              __unkeyed-2 = "<cmd>Telescope buffers<cr>";
              desc = "buffers";
            }

            {
              __unkeyed-1 = "<leader>o";
              __unkeyed-2 = "<cmd>Telescope oldfiles<cr>";
              desc = "recent";
            }

            # grep
            {
              __unkeyed-1 = "<leader>s";
              __unkeyed-2 = "<cmd>Telescope live_grep<cr>";
              desc = "grep";
            }

            {
              __unkeyed-1 = "<leader>l";
              __unkeyed-2 = "<cmd>Telescope live_grep grep_open_files=true<cr>";
              desc = "lines";
            }

            # nvim
            {
              __unkeyed-1 = "<leader>c";
              __unkeyed-2 = "<cmd>Telescope commands<cr>";
              desc = "commands";
            }

            {
              __unkeyed-1 = "<leader>p";
              __unkeyed-2 = "<cmd>Telescope builtin<cr>";
              desc = "pickers";
            }
          ];
        };
      };

      lz-n.plugins = [
        {
          __unkeyed-1 = "telescope-fzf-native.nvim";
          lazy = true;
        }
      ];
    };

    extraPlugins = [
      {
        plugin = pkgs.vimPlugins.telescope-fzf-native-nvim;
        optional = true;
      }
    ];
  };
}
