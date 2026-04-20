{
  config,
  lib,
  pkgs,
  ...
}:

{
  stylix.targets.neovim.enable = false;

  home.sessionVariables.MANPAGER = "nvim +Man!";

  xdg.configFile = {
    "nvim/init.lua".enable = lib.mkForce false;
    "nvim".source = config.lib.file.mkOutOfStoreSymlink config.flake + "/home/apps/nvim";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;

    plugins = with pkgs.vimPlugins; [
      snacks-nvim
      mini-nvim
      markview-nvim

      # code
      blink-cmp
      blink-ripgrep-nvim
      friendly-snippets
      nvim-lspconfig
      lsp-format-nvim

      # nav
      flash-nvim
      todo-comments-nvim

      # ui
      nvim-treesitter.withAllGrammars
      bufferline-nvim
      nvim-colorizer-lua
      blink-pairs
      nvim-lightbulb
      which-key-nvim

      typst-preview-nvim

      # home-manager generated init.lua
      (pkgs.writeTextFile {
        name = "hm-init";
        destination = "/lua/hm-init.lua";
        text = config.programs.neovim.initLua;
      })

      # colorscheme palette
      (pkgs.writeTextFile {
        name = "nixconfig";
        destination = "/lua/nixconfig.lua";
        text =
          # lua
          ''
            return {
              flake_dir = "${config.flake}",
              user = "${config.home.username}",
              dictionary = "${pkgs.scowl}/share/dict/wamerican.txt";
              palette = {
                ${lib.concatMapAttrsStringSep ",\n  " (
                  key: value: ''${key} = "${value}"''
                ) config.stylix.base16Scheme}
              }
            }
          '';
      })
    ];

    extraPackages = with pkgs; [
      nixd
      nixfmt

      emmylua-ls
      stylua

      vscode-langservers-extracted
      vtsls
      biome
      efm-langserver
      prettier

      pyrefly
      ruff

      bash-language-server
      fish-lsp
      shfmt

      tinymist
      typst
      typstyle

      clang-tools
      metals
      kdePackages.qtdeclarative
    ];
  };
}
