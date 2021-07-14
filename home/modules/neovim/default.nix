{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    withNodeJs = true;
    extraConfig = lib.readFile ./init.vim;

    ];
  };
}
