{ lib, pkgs, ... }:

{
  services.cliphist.enable = true;

  # copies primary clipboard into cliphist
  systemd.user.services.cliphist-primary = {
    Unit = {
      Description = "cliphist-primary";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };

    Service = {
      Type = "exec";
      ExecStart = "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --primary --watch cliphist store";
      Restart = "on-failure";
    };
  };
}
