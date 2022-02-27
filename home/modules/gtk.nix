{ pkgs, config, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Matcha-dark-azul";
      package = pkgs.matcha-gtk-theme;
    };

    iconTheme = {
      name = "Papirus-Dark-Maia";
      package = pkgs.papirus-maia-icon-theme;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-3.0/gtk2rc";
  };
}
