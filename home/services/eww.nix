{ lib, pkgs, ... }:

{
  systemd.user.services.eww-daemon = {
    Unit = {
      Description = "eww daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
      BindsTo = [ "tray.target" ];
    };

    Service = {
      ExecStart = "${lib.getExe pkgs.eww} --no-daemonize daemon";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
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
