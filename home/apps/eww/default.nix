{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.wayland.systemd) target;
  ewwCmd = "${lib.getExe pkgs.eww} --no-daemonize";
  ewwService = "eww-daemon.service";
in
{
  programs.eww.enable = true;

  home.packages = [ pkgs.acpi ];

  xdg.configFile."eww".source = config.lib.file.mkOutOfStoreSymlink config.flake + "/home/apps/eww";

  systemd.user.services = {
    eww-daemon = {
      Install.WantedBy = [ target ];

      Unit = {
        Description = "eww daemon";
        After = [ target ];
      };

      Service = {
        ExecStart = "${ewwCmd} daemon";
        Restart = "on-failure";
        RestartSec = "10";
      };
    };

    eww-bar = {
      Install.WantedBy = [ ewwService ];

      Unit = {
        Description = "eww bar";
        After = [ ewwService ];
      };

      Service = {
        ExecStart = "${ewwCmd} open bar";
        Restart = "on-failure";
        RestartSec = "10";
      };
    };
  };
}
