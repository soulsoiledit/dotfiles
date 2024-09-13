{ lib, pkgs, ... }:

{
  services.cliphist.enable = true;

  # copies primary clipboard into cliphist
  systemd.user.services.cliphist-primary = {
    Unit = {
      Description = "wl-copy";
      After = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
    };

    Service = {
      Type = "exec";
      ExecStart = "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --primary --watch cliphist store";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
