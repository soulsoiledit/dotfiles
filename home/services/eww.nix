{
  config,
  lib,
  pkgs,
  ...
}:

let
  target = config.wayland.systemd.target;
in
{
  systemd.user.services.eww-daemon = {
    Install.WantedBy = [ target ];

    Unit = {
      Description = "eww daemon";
      After = [ target ];
      PartOf = [ target ];
      BindsTo = [ "tray.target" ];
    };

    Service = {
      ExecStart = "${lib.getExe pkgs.eww} --no-daemonize daemon";
    };
  };

  systemd.user.services.eww-bar = {
    Unit = {
      Description = "eww status bar";
      After = [ "eww-daemon.service" ];
      PartOf = [ "eww-daemon.service" ];
    };

    Service = {
      ExecStart = "${lib.getExe pkgs.eww} open bar";
    };

    Install = {
      WantedBy = [ "eww-daemon.service" ];
    };
  };
}
