{
  programs.nixvim = {
    plugins = {
      grug-far = {
        enable = true;
      };

      telescope = {
        enable = true;

        extensions.fzf-native.enable = true;

        keymaps = {
          "<leader>b" = {
            options.desc = "buffers";
            action = "buffers";
          };
          "<leader>o" = {
            options.desc = "recent";
            action = "oldfiles";
          };
          "<leader>l" = {
            options.desc = "lines";
            action = "live_grep grep_open_files=true";
          };
          "<leader>c" = {
            options.desc = "commands";
            action = "commands";
          };
          "<leader>p" = {
            options.desc = "pickers";
            action = "builtin";
          };
        };
      };
    };

    # helper for getting project root
    extraConfigLuaPre = # lua
      ''
        local function git_cwd()
          local path = vim.fn.system("git rev-parse --show-toplevel")
          if vim.v.shell_error == 0 then
            return { cwd = string.sub(path, 1, -2) }
          end
          return { }
        end
      '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>f";
        options.desc = "files";
        action.__raw = ''function() require("telescope.builtin").find_files(git_cwd()) end'';
      }
      {
        mode = "n";
        key = "<leader>s";
        options.desc = "grep";
        action.__raw = ''function() require("telescope.builtin").live_grep(git_cwd()) end'';
      }
    ];
  };
}
