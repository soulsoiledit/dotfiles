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
}
