{ lib, pkgs, ... }:

let
  lock = "${lib.getExe' pkgs.systemd "loginctl"} lock-session";
  dpmsOn = "${lib.getExe pkgs.niri} msg action power-on-monitors";
  dpmsOff = "${lib.getExe pkgs.niri} msg action power-off-monitors";
  suspend = "${lib.getExe' pkgs.systemd "systemctl"} suspend";
in
{
  services.swayidle = {
    enable = true;

    timeouts = [
      {
        timeout = 5 * 60;
        command = lock;
      }

      {
        timeout = 10 * 60;
        command = dpmsOff;
        resumeCommand = dpmsOn;
      }

      {
        timeout = 30 * 60;
        command = suspend;
      }
    ];

    events = {
      before-sleep = "${dpmsOff}; ${lock}";
      after-resume = dpmsOn;
      unlock = dpmsOn;
    };
  };
}
