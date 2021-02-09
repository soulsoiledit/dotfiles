{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Adapta-Nokto";
      package = pkgs.adapta-gtk-theme;
    };

    iconTheme = {
      name = "Paper";
      package = pkgs.paper-icon-theme;
    };
  };
}
