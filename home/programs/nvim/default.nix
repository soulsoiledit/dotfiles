{
  config,
  inputs,
  pkgs,
  ...
}:

with config.lib.file;
let
  mkOptionalPlug =
    pkgs:
    map (pkg: {
      plugin = pkg;
      optional = true;
    }) pkgs;
in
{
  stylix.targets.neovim.enable = false;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [ wl-clipboard ];

    plugins =
      with pkgs.vimPlugins;
      mkOptionalPlug [
        snacks-nvim
        mini-nvim
        mini-base16
        mini-hues
        mini-trailspace
        mini-cursorword
        mini-diff

        blink-cmp
        friendly-snippets
        blink-ripgrep-nvim
        lsp-format-nvim
        none-ls-nvim
        nvim-lightbulb

        which-key-nvim
        todo-comments-nvim
        trouble-nvim
        grug-far-nvim
        flash-nvim

        (pkgs.symlinkJoin {
          name = "nvim-treesitter";
          paths = [
            nvim-treesitter
          ] ++ nvim-treesitter.withAllGrammars.dependencies;
        })
        lualine-nvim
        bufferline-nvim
        noice-nvim
        rainbow-delimiters-nvim
        nvim-colorizer-lua

        markview-nvim
        markdown-preview-nvim
        typst-preview-nvim
      ]
      ++ [ lz-n ];
  };

  xdg.configFile."nvim".source = mkOutOfStoreSymlink (inputs.self.lib.relative config.flake ./.);

  xdg.dataFile."dict".source = "${pkgs.scowl}/share/dict";
}
