{ config, ... }:

{
  home = {
    sessionVariables = {
      PAGER = "bat";
      MANPAGER = "nvim +Man!";

      # use native wayland when possible
      NIXOS_OZONE_WL = 1;
    };

    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
      "${config.xdg.dataHome}/cargo/bin"
    ];
  };
}
