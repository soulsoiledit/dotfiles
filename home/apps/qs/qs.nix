{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.quickshell = {
    enable = true;
    package = pkgs.symlinkJoin {
      name = "quickshell-wrapped";
      meta.mainProgram = pkgs.quickshell.meta.mainProgram;
      paths = with pkgs; [
        quickshell

        libnotify
        niri
        systemd
        vips
      ];
    };
    systemd.enable = true;
  };

  xdg.configFile."quickshell".source =
    config.lib.file.mkOutOfStoreSymlink config.flake + "/home/apps/qs";

  services.swayidle = {
    enable = true;
    events.before-sleep = "${lib.getExe' pkgs.systemd "loginctl"} lock-session";
  };
}
