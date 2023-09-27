{ pkgs, config, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Mocha-Compact-Red-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "red" ];
        size = "compact";
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-3.0/gtk2rc";
  };
}
