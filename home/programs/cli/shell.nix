{ config, ... }:

{
  home = {
    sessionVariables = {
      PAGER = "bat";
      MANPAGER = "nvim +Man!";

      # use native wayland when possible
      NIXOS_OZONE_WL = "1";

      # make steam ui readable
      # STEAM_FORCE_DESKTOPUI_SCALING = 1.5;

      # set qt style
      QT_QPA_PLATFORMTHEME = config.qt.platformTheme.name;
    };

    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
      "${config.xdg.dataHome}/cargo/bin"
    ];
  };
}
