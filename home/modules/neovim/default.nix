{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    # extraConfig = lib.readFile ./init.vim;
    extraPackages = with pkgs; [
      gcc
      universal-ctags
      code-minimap
      ripgrep
      fd

      rnix-lsp
      pandoc
    ];

    # plugins = with pkgs.vimPlugins; [
    # ];
  };

  programs.lazygit.enable = true;
  programs.gh.enable = true;
}
