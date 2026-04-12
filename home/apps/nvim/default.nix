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

  xdg.configFile = {
    "nvim/init.lua".enable = false;
    "nvim".source = config.lib.file.mkOutOfStoreSymlink config.flake + "/home/apps/nvim";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;

    plugins =
      with pkgs.vimPlugins;
      [
        snacks-nvim
        mini-nvim
        markview-nvim

        nvim-colorizer-lua

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

        # ui
        nvim-treesitter.withAllGrammars
        bufferline-nvim
        noice-nvim
        which-key-nvim
        blink-pairs
        nvim-lightbulb

        # lang
        typst-preview-nvim
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
