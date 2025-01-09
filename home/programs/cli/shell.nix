{ config, ... }:

{
  home = {
    sessionVariables = {
      PAGER = "bat";
      MANPAGER = "nvim +Man!";

      # use native wayland when possible
      NIXOS_OZONE_WL = 1;

      # set qt style
      QT_QPA_PLATFORMTHEME = config.qt.platformTheme.name;
    };

    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
      "${config.xdg.dataHome}/cargo/bin"
    ];
  };
}
