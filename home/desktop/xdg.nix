{ config, lib, ... }:

{
  xdg.enable = true;

  home = {
    preferXdgDirectories = true;

    sessionVariables = {
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
      _JAVA_OPTIONS = ''-Djava.util.prefs.userRoot="${config.xdg.configHome}"/java'';
    };
  };

  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

  home.file = {
    ".icons/${config.home.pointerCursor.name}".enable = lib.mkForce false;
    ".icons/default/index.theme".enable = lib.mkForce false;
  };

  xresources.path = "${config.xdg.configHome}/X11/xresources";
}
