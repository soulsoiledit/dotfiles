{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      dropbar-nvim
    ];

    plugins = {
      # statusline and tabline
      bufferline.enable = true;
      lualine = {
        enable = true;
        settings.options.disabled_filetypes = [
          "snacks_dashboard"
        ];
      };

      # icons
      mini = {
        mockDevIcons = true;
        modules.icons = { };
      };

      # vim.ui.select
      dressing = {
        enable = true;
        settings.input.enabled = false;
      };

      snacks.settings = {
        # statuscolumn
        statuscolumn.enable = true;
        # vim.notify
        notifier.enable = true;
        # vim.ui.input
        input = { };

        # start screen
        dashboard = {
          enable = true;
          sections = [
            { section = "header"; }
            {
              section = "keys";
              gap = 1;
              padding = 1;
            }
            # TODO: Figure out how to measure startup within nixvim
            # { section = "startup"; }
          ];
        };

      };

      # general ui
      noice = {
        enable = true;

        settings = {
          lsp.override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
          };

          presets = {
            bottom_search = true;
            command_palette = true;
            long_message_to_split = true;
          };
        };
      };
    };
  };
}
