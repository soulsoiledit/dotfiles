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
    ncdu trash-cli nix-tree patchelf
    xplr 

    (discord.overrideAttrs (_: rec {
      version = "0.0.16";
      src = builtins.fetchTarball {
        url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
        sha256 = "05s7irhw984slalnf7q5rps9i8izq542lnman9s1x6csd26r157s";
      };
    }))
  ];
}
