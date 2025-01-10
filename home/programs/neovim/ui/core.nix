{
  config,
  lib,
  pkgs,
  ...
}:

let
  tsGrammars = config.programs.nixvim.plugins.treesitter.grammarPackages;
in
{
  programs.nixvim.plugins = {
    # syntax
    treesitter = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";

      # from https://github.com/NixOS/nixpkgs/pull/319233
      # vastly decreases startup time, maybe buggy
      packageDecorator = lib.mkForce (
        pkg:
        pkg.overrideAttrs {
          passthru.dependencies = lib.singleton (
            pkgs.runCommandLocal "vimplugin-treesitter-grammars" { } (
              "mkdir -p $out/parser\n"
              + (lib.concatMapStringsSep "\n" (
                grammar:
                let
                  name = lib.head (lib.splitString "-" grammar.pname);
                in
                "cp ${grammar}/parser $out/parser/${name}.so"
              ) tsGrammars)
            )
          );
        }
      );

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

    # vim.ui.select/input
    dressing = {
      enable = true;
      lazyLoad.settings = {
        event = "DeferredUIEnter";
        before.__raw = ''
          function()
            require("lz.n").trigger_load("telescope.nvim")
          end
        '';
      };
    };

    snacks.settings = {
      # vim.notify
      notifier.enabled = true;

      # statuscolumn
      statuscolumn.enabled = true;

      # start screen
      dashboard = {
        enabled = true;
        preset.header = ''
           ▐ ▄  ▄· ▄▌ ▄▄▄·  ▌ ▐·▪  • ▌ ▄ ·. 
          •█▌▐█▐█▪██▌▐█ ▀█ ▪█·█▌██ ·██ ▐███▪
          ▐█▐▐▌▐█▌▐█▪▄█▀▀█ ▐█▐█•▐█·▐█ ▌▐▌▐█·
          ██▐█▌ ▐█▀·.▐█▪ ▐▌ ███ ▐█▌██ ██▌▐█▌
          ▀▀ █▪  ▀ •  ▀  ▀ . ▀  ▀▀▀▀▀  █▪▀▀▀
        '';
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
}
