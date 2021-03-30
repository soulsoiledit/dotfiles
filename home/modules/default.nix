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
    ./imv.nix
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
    virt-manager
    awesome
    # xmonad-with-packages xmobar
    # stumpwm

    unzip ncdu bc trash-cli nix-tree patchelf

    (discord.overrideAttrs (_: rec {
      version = "0.0.14";
      src = builtins.fetchTarball {
        url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
        sha256 = "0hcryk53mv9ci94y5y8h7hvc4qr7k5mxj9wjxbbpl7j6spz2rkki";
      };
    }))
    multimc
  ];

  programs.obs-studio.enable = true;
  programs.kakoune.enable = true;
}
