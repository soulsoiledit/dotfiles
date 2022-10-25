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

  xdg.dataFile."themes/Catppuccin-Mocha-Lavender".source = pkgs.fetchzip
    {
      name = "catpuccin-mocha-lavender";
      url = "https://github.com/catppuccin/gtk/releases/download/v-0.2.7/Catppuccin-Mocha-Lavender.zip";
      sha256 = "sha256-pPTtqzeUSBGdbtdgWVef4tKLafe2b5NQcjd48C0wpR8=";
      stripRoot = false;
    } + "/Catppuccin-Mocha-Lavender";
}
