{ lib, pkgs, ... }:

let
  loginctl = lib.getExe' pkgs.systemd "loginctl";
  niri = lib.getExe pkgs.niri;
  systemctl = lib.getExe' pkgs.systemd "systemctl";
in
{
  services.swayidle = {
    enable = true;

    events."before-sleep" = "${loginctl} lock-session";

    timeouts = [
      {
        timeout = 5 * 60;
        command = "${niri} msg action power-off-monitors";
        resumeCommand = "${niri} msg action power-on-monitors";
      }

      {
        timeout = 10 * 60;
        command = "${loginctl} lock-session";
      }

      {
        timeout = 20 * 60;
        command = "${systemctl} suspend";
      }
    ];
  };
}
