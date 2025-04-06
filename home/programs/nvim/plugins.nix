{ pkgs, ... }:

let
  mkOptionalPlug =
    pkgs:
    map (pkg: {
      plugin = pkg;
      optional = true;
    }) pkgs;
in
{
  programs.neovim.plugins =
    with pkgs.vimPlugins;
    [ lz-n ]
    ++ mkOptionalPlug [
      # multi
      snacks-nvim
      mini-nvim
      mini-base16
      mini-pairs
      mini-surround

      # code
      blink-cmp
      blink-ripgrep-nvim
      friendly-snippets
      ts-comments-nvim
      lsp-format-nvim
      mini-diff

      # nav
      todo-comments-nvim
      trouble-nvim
      grug-far-nvim
      flash-nvim

      # ui
      (pkgs.symlinkJoin {
        name = "nvim-treesitter";
        paths = [
          nvim-treesitter
        ] ++ nvim-treesitter.withAllGrammars.dependencies;
      })
      lualine-nvim
      bufferline-nvim
      noice-nvim
      which-key-nvim
      rainbow-delimiters-nvim
      nvim-colorizer-lua

      nvim-lightbulb
      mini-cursorword
      mini-trailspace

      # lang
      markview-nvim
      markdown-preview-nvim
      typst-preview-nvim
    ];
}
