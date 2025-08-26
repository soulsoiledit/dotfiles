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
  programs.neovim.plugins =
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
}
