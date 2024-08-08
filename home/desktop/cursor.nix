{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.pointerCursor = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 24;

    gtk.enable = true;
  };

  # dont generate ~/.icons/
  catppuccin.pointerCursor.enable = false;
  home.file.".icons/${config.home.pointerCursor.name}".enable = lib.mkForce false;
  home.file.".icons/default/index.theme".enable = lib.mkForce false;
}
