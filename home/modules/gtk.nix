{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Matcha-dark-sea";
      package = pkgs.matcha-gtk-theme;
    };

    iconTheme = {
      name = "Papirus-Dark-Maia";
    package = pkgs.papirus-maia-icon-theme;
    };
  };
}
