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
    ncdu
    trash-cli
    nix-tree
    xplr

    (discord.overrideAttrs (_: rec {
      #src = builtins.fetchTarball {
      #  #url = "https://discordapp.com/api/download?platform=linux&format=tar.gz";
      #  sha256 = "1hl01rf3l6kblx5v7rwnwms30iz8zw6dwlkjsx2f1iipljgkh5q4";
      #};
    }))
  ];

  #programs.waybar.enable = true;
  #programs.waybar.systemd.enable = false;

  services.swayidle = {
    #enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -f"; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock-effects}/bin/swaylock -f --grace=5"; }
    ];
  };

  #systemd.user.services.swayidle.Install = { WantedBy = [ "graphical-session.target" ]; };
  
  programs.swaylock.settings = {
    screenshots = true;
    effect-blur = "5x5";
    fade-in = 0.25;
    indicator = true;
    clock = true;
    ignore-empty-password = true;
  };

  services.picom = {
      enable = true;
      fade = true;
      vSync = true;
      backend = "glx";
      fadeDelta = 5;
  };
}
