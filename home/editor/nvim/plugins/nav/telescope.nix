{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      extensions = {
        fzf-native.enable = true;
      };

      keymaps = {
        "<leader>fs" = {
          action = "live_grep";
          options.desc = "live grep";
        };
        "<leader>fb" = {
          action = "buffers";
          options.desc = "buffers";
        };
        "<leader>fr" = {
          action = "oldfiles";
          options.desc = "recent files";
        };
        "<leader>fc" = {
          action = "commands";
          options.desc = "commands";
        };
        "<leader>fe" = {
          action = "command_history";
          options.desc = "command history";
        };
        "<leader>fh" = {
          action = "help_tags";
          options.desc = "help";
        };
        "<leader>fk" = {
          action = "keymaps";
          options.desc = "keymaps";
        };
        "<leader>fm" = {
          action = "marks";
          options.desc = "marks";
        };
        "<leader>fp" = {
          action = "builtin";
          options.desc = "pickers";
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        lua = true;
        action = # lua
          ''
            function()
              local opts = {}

              local builtin = require('telescope.builtin')
              local cwd = vim.fn.getcwd()
              local is_inside_work_tree = {}

              vim.fn.system("git rev-parse --is-inside-work-tree")
              is_inside_work_tree[cwd] = vim.v.shell_error == 0

              if is_inside_work_tree[cwd] then
                builtin.git_files(opts)
              else
                builtin.find_files(opts)
              end
            end
          '';
        options.desc = "files";
      }

      {
        mode = "n";
        key = "<leader>fa";
        lua = true;
        action = # lua
          ''
            function()
              require('telescope.builtin').find_files({
                hidden = true,
                no_ignore = true
              })
            end
          '';
        options = {
          desc = "all files";
        };
      }

      {
        mode = "n";
        key = "<leader>fS";
        lua = true;
        action = # lua
          ''
            function()
              require('telescope.builtin').live_grep({
                grep_open_files = true
              })
            end
          '';
        options = {
          desc = "current file grep";
        };
      }
    ];
  };
}
