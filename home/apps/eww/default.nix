{
  config,
  lib,
  pkgs,
  ...
}:

let
  ewwService = "eww.service";
in
{
  programs.eww = {
    enable = true;
    systemd.enable = true;
  };

  home.packages = [ pkgs.glib ];

  xdg.configFile."eww".source = config.lib.file.mkOutOfStoreSymlink config.flake + "/home/apps/eww";

  systemd.user.services.eww-bar = {
    Install.WantedBy = [ ewwService ];
    Service.ExecStart = "${lib.getExe pkgs.eww} --no-daemonize open bar";

    Unit = {
      Description = "eww bar";
      After = [ ewwService ];
    };
  };
}
