{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    # syntax
    treesitter = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";

      # NOTE: https://github.com/NixOS/nixpkgs/pull/355680
      # join parsers into nvim-treesitter, can be buggy
      package = pkgs.symlinkJoin {
        name = "nvim-treesitter";
        paths =
          with pkgs.vimPlugins;
          [
            nvim-treesitter
          ]
          ++ nvim-treesitter.withAllGrammars.dependencies;
      };
      nixGrammars = false;

      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };

    # status
    lualine = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
      settings.options.disabled_filetypes = [ "snacks_dashboard" ];
    };

    bufferline = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
    };

    # icons
    mini = {
      mockDevIcons = true;
      modules.icons = { };
    };

    snacks.settings = {
      # vim.notify
      notifier.enabled = true;

      # vim.ui.input
      input.enabled = true;
      styles.input = {
        relative = "cursor";
        width = 32;
      };

      # vim.ui.select
      picker.enabled = true;

      # dashboard
      dashboard = {
        enabled = true;
        preset = {
          header = ''
             ▐ ▄  ▄· ▄▌ ▄▄▄·  ▌ ▐·▪  • ▌ ▄ ·.
            •█▌▐█▐█▪██▌▐█ ▀█ ▪█·█▌██ ·██ ▐███▪
            ▐█▐▐▌▐█▌▐█▪▄█▀▀█ ▐█▐█•▐█·▐█ ▌▐▌▐█·
            ██▐█▌ ▐█▀·.▐█▪ ▐▌ ███ ▐█▌██ ██▌▐█▌
            ▀▀ █▪  ▀ •  ▀  ▀ . ▀  ▀▀▀▀▀  █▪▀▀▀
          '';

          keys = [
            {
              icon = " ";
              key = "f";
              desc = "Find File";
              action = ":lua Snacks.picker.pick('smart')";
            }
            {
              icon = " ";
              key = "s";
              desc = "Find Text";
              action = ":lua Snacks.picker.pick('live_grep')";
            }
            {
              icon = " ";
              key = "n";
              desc = "New File";
              action = ":ene | startinsert";
            }
            {
              icon = " ";
              key = "c";
              desc = "Config";
              action = ":lua Snacks.picker.pick('files', { cwd = '${config.home.homeDirectory}/code/dotfiles' })";
            }
            {
              icon = " ";
              key = "q";
              desc = "Quit";
              action = ":qa";
            }
          ];
        };

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
      lazyLoad.settings.event = "DeferredUIEnter";

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

  programs.nixvim.highlight = {
    SnacksNormal.link = "Normal";
    SnacksPicker.link = "Normal";
    SnacksPickerBorder.link = "Comment";
  };
}
