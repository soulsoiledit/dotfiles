{ config, pkgs, lib, inputs, master, ... }:

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
    ncdu
    trash-cli
    nix-tree
    xplr
    # polymc
    spotify

    ferium
    (pkgs.discord.override { nss = pkgs.nss_latest; })

    brightnessctl
    acpi
    dunst
    playerctl
    pamixer

    source-han-sans
    protonvpn-gui

    piper
  ];

  fonts.fontconfig.enable = true;

  services.playerctld.enable = true;
  programs.starship.enable = true;
  programs.firefox = {
    enable = true;
    profiles.soil = {
      settings = {
        "browser.bookmarks.showMobileBookmarks" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layout.css.devPixelsPerPx" = 2;
      };
    };
  };
  programs.fzf.enable = true;

  xdg.enable = true;
  xsession.enable = true;

  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    gtk.enable = true;
  };

  services.udiskie.enable = true;
  services.flameshot.enable = true;

  programs.zathura = {
    enable = true;
    options = {
      default-bg = "#222";
      default-fg = "#ddd";
    };
  };
}
