{
  programs.nixvim.plugins = {
    # syntax
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };

    # status
    lualine = {
      enable = true;
      settings.options.disabled_filetypes = [ "snacks_dashboard" ];
    };

    bufferline.enable = true;

    # icons
    mini = {
      mockDevIcons = true;
      modules.icons = { };
    };

    # vim.ui.select/input
    dressing.enable = true;

    snacks.settings = {
      # vim.notify
      notifier.enabled = true;

      # start screen
      dashboard = {
        enabled = true;
        sections = [
          { section = "header"; }
          {
            section = "keys";
            gap = 1;
            padding = 1;
          }
        ];
      };
    };

    # general ui
    noice = {
      enable = true;

      settings = {
        lsp = {
          signature.enabled = false;
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
          };
        };

        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
        };
      };
    };
  };
}
