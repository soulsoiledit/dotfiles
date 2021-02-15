{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./applications.nix
    ./direnv.nix
    ./dunst.nix
    ./emacs
    ./firefox.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./gtk.nix
    ./htop.nix
    ./imv
    ./lf
    ./neovim
    ./picom.nix
    ./redshift.nix
    ./rofi
    ./scripts
    ./services.nix
    ./spectrwm
    ./starship.nix
    ./udiskie.nix
    ./vars.nix
    ./x11.nix
  ];

  home.packages = with pkgs; [
    # xmonad-with-packages xmobar
    awesome
    unzip ncdu bc trash-cli nix-tree patchelf
    discord
    (pkgs.multimc.override { jdk8 = pkgs.jdk11; })
  ];

  programs.obs-studio.enable = true;
}
