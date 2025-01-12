{
  config,
  lib,
  pkgs,
  ...
}:

let
  target = config.wayland.systemd.target;
  ewwService = "eww-daemon.service";
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
    Install.WantedBy = [ ewwService ];

    Unit = {
      Description = "eww bar";
      After = [ ewwService ];
      PartOf = [ ewwService ];
    };

    Service = {
      ExecStart = "${lib.getExe pkgs.eww} open bar";
    };
  };
}
