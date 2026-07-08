{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
  };

  xdg.configFile."quickshell".source =
    config.lib.file.mkOutOfStoreSymlink config.flake + "/home/apps/qs";

  services.swayidle = {
    enable = true;
    events.lock = "${lib.getExe config.programs.quickshell.package} ipc call lockscreen lock";
    events.before-sleep = "${lib.getExe' pkgs.systemd "loginctl"} lock-session";
  };
}
