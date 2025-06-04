{ pkgs, ... }:

let
  mkLazyPlugs = map (plug: {
    plugin = plug;
    optional = true;
  });
in
{
  programs.neovim.plugins =
    with pkgs.vimPlugins;
    [ lz-n ]
    ++ mkLazyPlugs [
      # multi
      snacks-nvim
      mini-nvim

      # code
      blink-cmp
      blink-ripgrep-nvim
      friendly-snippets
      ts-comments-nvim
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
      markview-nvim
      markdown-preview-nvim
      typst-preview-nvim
    ];
}
