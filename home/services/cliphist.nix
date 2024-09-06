{ lib, pkgs, ... }:

{
  services.cliphist.enable = true;

  # copies primary clipboard into cliphist
  systemd.user.services.cliphist-primary = {
    Unit = {
      Description = "cliphist-primary";

      WantedBy = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --primary --watch cliphist store";
      Restart = "on-failure";
    };
  };
}
