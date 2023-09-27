{ pkgs, config, inputs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Mocha-Lavender";
      package = pkgs.catppuccin-gtk;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-maia-icon-theme;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-3.0/gtk2rc";
  };
}
