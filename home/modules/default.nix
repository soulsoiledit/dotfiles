{ config, pkgs, lib, ... }:

{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./dunst.nix
    ./firefox.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./gtk.nix
    ./htop.nix
    ./imv.nix
    ./lf.nix
    ./neovim
    ./picom.nix
    ./redshift.nix
    ./rofi.nix
    ./services.nix
    ./starship.nix
    ./udiskie.nix
    ./vars.nix
    ./wm
    ./x11.nix
  ];

  home.packages = with pkgs; [
    polymc
    awesome
    # xmonad-with-packages xmobar
    # stumpwm
    ncdu
    trash-cli
    nix-tree
    patchelf
    xplr

    (discord.overrideAttrs (_: rec {
      src = builtins.fetchTarball {
        url =
          "https://discordapp.com/api/download?platform=linux&format=tar.gz";
        sha256 = "0hdgif8jpp5pz2c8lxas88ix7mywghdf9c9fn95n0dwf8g1c1xbb";
      };
    }))
  ];
}
