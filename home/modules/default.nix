{ config, pkgs, lib, ... }:

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
    ./rofi.nix
    ./services.nix
    ./starship.nix
    ./udiskie.nix
    ./vars.nix
    ./wm
    ./x11.nix
  ];
  
  home.packages = with pkgs; [
    multimc
    openjdk16
    awesome
    # xmonad-with-packages xmobar
    # stumpwm
    unzip ncdu trash-cli nix-tree patchelf
    xplr 

    (discord.overrideAttrs (_: rec {
      version = "0.0.15";
      src = builtins.fetchTarball {
        url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
        sha256 = "1ahj4bhdfd58jcqh54qcgafljqxl1747fqqwxhknqlasa83li75n";
      };
    }))
  ];

  programs.obs-studio.enable = true;
  programs.kakoune.enable = true;

  home.activation = {
    removeClutter = ''
      $DRY_RUN_CMD rm -rf ~/.config/nvim/init.vim ~/.icons/ ~/.config/emacs/
      $DRY_RUN_CMD mv ~/.emacs.d/ ~/.config/emacs/ 
    '';
  };
}
