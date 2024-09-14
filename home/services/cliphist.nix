{
  config,
  lib,
  pkgs,
  ...
}:

let
  systemdTarget = config.services.cliphist.systemdTarget;
in
{
  services.cliphist.enable = true;

  systemd.user.services.cliphist = {
    Unit = {
      After = [ systemdTarget ];
      Wants = [ systemdTarget ];
    };
  };

  systemd.user.services.cliphist-images = {
    Unit = {
      After = [ systemdTarget ];
      Wants = [ systemdTarget ];
    };
  };

  # copies primary clipboard into cliphist
  systemd.user.services.cliphist-primary = {
    Unit = {
      Description = "wl-copy";
      Wants = [ systemdTarget ];
      After = [ systemdTarget ];
    };

    Service = {
      Type = "exec";
      ExecStart = "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --primary --watch cliphist store";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ systemdTarget ];
    };
  };
}
