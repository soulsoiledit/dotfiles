{ config, ... }:

{
  home.sessionVariables = {
    PAGER = "bat";
    MANPAGER = "nvim +Man!";

    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    _JAVA_OPTIONS = ''-Djava.util.prefs.userRoot="${config.xdg.configHome}"/java'';
  };

  home.sessionVariables = {
    # use native wayland when possible
    NIXOS_OZONE_WL = "1";

    # make steam ui readable
    # STEAM_FORCE_DESKTOPUI_SCALING = 1.5;

    # set qt style
    QT_QPA_PLATFORMTHEME = config.qt.platformTheme.name;
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.xdg.dataHome}/cargo/bin"
  ];
}
