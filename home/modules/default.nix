{ config, pkgs, lib, ... }:

{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./dunst.nix
    ./fish.nix
    ./gammastep.nix
    ./git.nix
    ./gtk.nix
    ./htop.nix
    ./imv.nix
    ./lf.nix
    ./neovim
    ./rofi.nix
    ./vars.nix

    ./xorg
    #./wayland
  ];



  home.packages = with pkgs; [
    ncdu trash-cli nix-tree xplr
    polymc discord spotify

    brightnessctl acpi dunst 
    playerctl pamixer
  ];

  systemd.user.startServices = true;
  services.playerctld.enable = true;
  programs.starship.enable = true;
  programs.firefox = {
    enable = true;
    profiles.soil = { };
  };
  programs.fzf.enable = true;

  xdg.enable = true;
  xsession.enable = true;

  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    gtk.enable = true;
  };

  services.udiskie = {
    enable = true;
    tray = "never";
  };
}
