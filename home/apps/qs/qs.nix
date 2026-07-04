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

  home.packages = [ pkgs.vips ];

  xdg.configFile."quickshell".source =
    config.lib.file.mkOutOfStoreSymlink config.flake + "/home/apps/qs";

  services.swayidle = {
    enable = true;
    events.before-sleep = "${lib.getExe' pkgs.systemd "loginctl"} lock-session";
  };

  # wpaper: ~50m
  # eww: ~130m
  # vicinae: ~130m
  # mako: ~30.0m
  # total: ~340m

  # qs: 200->30m?
}
