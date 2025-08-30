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
  xdg = {
    configFile = {
      "nvim".source = config.lib.file.mkOutOfStoreSymlink (config.flake + "/home/programs/nvim");
      "biome/config.json".text = builtins.toJSON {
        formatter.indentStyle = "space";
      };
    };
    dataFile."dict/words".source = "${pkgs.scowl}/share/dict/wamerican.txt";
  };

  home.sessionVariables.MANPAGER = "nvim +Man!";

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
        lsp-format-nvim

        # nav
        todo-comments-nvim
        trouble-nvim
        grug-far-nvim
        flash-nvim

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
      emmylua-ls
      stylua

      bash-language-server
      fish-lsp
      shfmt

      nil
      nixd
      nixfmt

      basedpyright
      ruff

      vscode-langservers-extracted
      vtsls
      biome

      rust-analyzer
      rustc
      cargo
      rustfmt

      # haskell-language-server
      # ghc
      # ormolu
      # haskellPackages.cabal-gild

      tinymist
      typst
      typstyle

      texlab
      tectonic
      texlivePackages.latexindent
      zathura

      # data
      yaml-language-server
      taplo

      # formatting
      efm-langserver
      nodePackages.prettier

      # misc
      clang-tools
      jdt-language-server
      kotlin-language-server
      ruby-lsp
      zls
    ];
  };
}
