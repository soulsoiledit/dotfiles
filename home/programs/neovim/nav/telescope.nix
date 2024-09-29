{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      extensions = {
        fzf-native.enable = true;
        undo.enable = true;
      };

      keymaps = {
        "<leader>b" = {
          action = "buffers";
          options.desc = "buffers";
        };
        "<leader>r" = {
          action = "oldfiles";
          options.desc = "recent files";
        };
        "<leader>c" = {
          action = "commands";
          options.desc = "commands";
        };
        "<leader>u" = {
          action = "undo";
          options.desc = "undo";
        };
        "<leader>p" = {
          action = "builtin";
          options.desc = "pickers";
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>f";
        action.__raw = # lua
          ''
            function()
              local function is_git_repo()
                vim.fn.system("git rev-parse --is-inside-work-tree")
                return vim.v.shell_error == 0
              end

              local function get_git_root()
                local dot_git_path = vim.fn.finddir(".git", ".;")
                return vim.fn.fnamemodify(dot_git_path, ":h")
              end

              local opts = {}
              if is_git_repo() then
                opts = {
                  cwd = get_git_root(),
                }
              end
              require("telescope.builtin").find_files(opts)
            end
          '';
        options.desc = "files";
      }

      {
        mode = "n";
        key = "<leader>F";
        action.__raw = # lua
          ''
            function()
              local function is_git_repo()
                vim.fn.system("git rev-parse --is-inside-work-tree")
                return vim.v.shell_error == 0
              end

              local function get_git_root()
                local dot_git_path = vim.fn.finddir(".git", ".;")
                return vim.fn.fnamemodify(dot_git_path, ":h")
              end

              local opts = {
                hidden = true,
                no_ignore = true
              }
              if is_git_repo() then
                opts = {
                  cwd = get_git_root(),
                }
              end
              require("telescope.builtin").find_files(opts)
            end
          '';
        options.desc = "all files";
      }

      {
        mode = "n";
        key = "<leader>s";
        action.__raw = # lua
          ''
            function()
              local function is_git_repo()
                vim.fn.system("git rev-parse --is-inside-work-tree")
                return vim.v.shell_error == 0
              end

              local function get_git_root()
                local dot_git_path = vim.fn.finddir(".git", ".;")
                return vim.fn.fnamemodify(dot_git_path, ":h")
              end

              local opts = {}
              if is_git_repo() then
                opts = {
                  cwd = get_git_root(),
                }
              end

              require("telescope.builtin").live_grep(opts)
            end
          '';
        options.desc = "grep";
      }

      {
        mode = "n";
        key = "<leader>S";
        action.__raw = # lua
          ''
            function()
              require('telescope.builtin').live_grep({
                grep_open_files = true
              })
            end
          '';
        options = {
          desc = "grep buffers";
        };
      }
    ];
  };
}
