{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./gamma.nix
    ./idle.nix
    ./launcher.nix
    ./lock.nix
    ./notify.nix
    ./services.nix
    ./wall.nix
  ];

  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    catppuccin = {
      enable = true;
      icon.enable = false;
      cursor.enable = false;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
    style.catppuccin.enable = true;
  };

  home.pointerCursor = {
    gtk.enable = true;
    size = 24;
    name = "breeze_cursors";
    package = pkgs.kdePackages.breeze;
  };

  # dont generate ~/.icons/
  home.file.".icons/${config.home.pointerCursor.name}".enable = lib.mkForce false;
  home.file.".icons/default/index.theme".enable = lib.mkForce false;
}
