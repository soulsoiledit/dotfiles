{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    font = {
      name = "sans-serif";
      size = 10;
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    theme = {
      # customize adw theme
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };

    catppuccin.icon.enable = false;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };
}
