{
  config,
  lib,
  pkgs,
  ...
}:

{
  stylix.targets.neovim.enable = false;

  home.sessionVariables.MANPAGER = "nvim +Man!";

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink config.flake + "/home/apps/nvim";

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;

    sideloadInitLua = true;
    initLua =
      # lua
      ''
        nix = {
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

      {
        plugin = typst-preview-nvim;
        optional = true;
      }
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
      typstyle

      clang-tools
      metals
      kdePackages.qtdeclarative
    ];
  };
}
