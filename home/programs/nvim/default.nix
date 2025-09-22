{
  config,
  lib,
  pkgs,
  ...
}:

let
  mkOptPlugs = map (plug: {
    plugin = plug;
    optional = true;
  });
in
{
  stylix.targets.neovim.enable = false;

  home.sessionVariables.MANPAGER = "nvim +Man!";

  xdg = {
    configFile = {
      "nvim".source = config.lib.file.mkOutOfStoreSymlink (config.flake + "/home/programs/nvim");
      "biome/config.json".text = builtins.toJSON {
        formatter.indentStyle = "space";
      };
    };
    dataFile."dict/words".source = "${pkgs.scowl}/share/dict/wamerican.txt";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins =
      with pkgs.vimPlugins;
      [
        snacks-nvim
        mini-nvim
        markview-nvim

        # colorscheme palette
        (pkgs.writeTextFile {
          name = "nixpalette";
          destination = "/lua/nixpalette.lua";
          text =
            # lua
            ''
              return {
                ${lib.concatMapAttrsStringSep ",\n  " (
                  key: value: ''${key} = "${value}"''
                ) config.stylix.base16Scheme}
              }
            '';
        })
      ]
      ++ mkOptPlugs [
        # code
        blink-cmp
        blink-ripgrep-nvim
        friendly-snippets
        nvim-lspconfig
        lsp-format-nvim

        # nav
        flash-nvim
        todo-comments-nvim
        trouble-nvim
        grug-far-nvim

        # ui
        (pkgs.symlinkJoin {
          name = "nvim-treesitter";
          paths = nvim-treesitter.withAllGrammars.dependencies ++ [
            nvim-treesitter
          ];
        })
        lualine-nvim
        bufferline-nvim
        noice-nvim
        which-key-nvim
        rainbow-delimiters-nvim
        nvim-colorizer-lua
        nvim-lightbulb

        # lang
        typst-preview-nvim
      ];

    extraPackages = with pkgs; [
      nil
      nixfmt

      emmylua-ls
      stylua

      rust-analyzer
      rustc
      cargo
      rustfmt

      # haskell-language-server
      # ghc
      # ormolu
      # haskellPackages.cabal-fmt

      vscode-langservers-extracted
      vtsls
      biome
      efm-langserver
      nodePackages.prettier

      pyrefly
      ruff

      bash-language-server
      fish-lsp
      shfmt

      tinymist
      typst
      typstyle

      clang-tools
      jdt-language-server
      kdePackages.qtdeclarative
    ];
  };
}
