{ config, lib, ... }:

let
  configHome = config.xdg.configHome;
  dataHome = config.xdg.dataHome;
in
{
  xdg = {
    enable = true;
    portal.config.niri.default = "gtk,gnome";
  };

  home = {
    preferXdgDirectories = true;

    sessionVariables = {
      CARGO_HOME = "${dataHome}/cargo";
      RUSTUP_HOME = "${dataHome}/rustup";
      _JAVA_OPTIONS = ''-Djava.util.prefs.userRoot="${configHome}"/java'';
    };
  };

  gtk.gtk2.configLocation = "${configHome}/gtk-2.0/gtkrc";

  home.file = {
    ".icons/${config.home.pointerCursor.name}".enable = lib.mkForce false;
    ".icons/default/index.theme".enable = lib.mkForce false;
  };

  xresources.path = "${configHome}/X11/xresources";
}
