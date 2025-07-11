{ config, lib, ... }:

let
  configHome = config.xdg.configHome;
  dataHome = config.xdg.dataHome;
in
{
  xdg.enable = true;

  home = {
    preferXdgDirectories = true;

    sessionVariables = {
      CARGO_HOME = "${dataHome}/cargo";
      RUSTUP_HOME = "${dataHome}/rustup";
      _JAVA_OPTIONS = ''-Djava.util.prefs.userRoot="${configHome}"/java'';
    };
  };

  gtk.gtk2.configLocation = "${configHome}/gtk-2.0/gtkrc";

  home.pointerCursor.dotIcons.enable = false;

  xdg.configFile."pulse/client.conf".text = ''
    cookie-file = ${configHome}/pulse/cookie
  '';

  xresources.path = "${configHome}/X11/xresources";
}
