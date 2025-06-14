{
  config,
  lib,
  pkgs,
  ...
}:

let
  loginctl = lib.getExe' pkgs.systemd "loginctl";
  niri = lib.getExe pkgs.niri;
  brightnessctl = lib.getExe pkgs.brightnessctl;
  systemctl = lib.getExe' pkgs.systemd "systemctl";
in
{
  services.swayidle = {
    enable = true;

    events = [
      {
        event = "lock";
        command = "${systemctl} --user start lockscreen.service";
      }

      {
        event = "before-sleep";
        command = "${loginctl} lock-session";
      }
    ];

    timeouts = [
      {
        timeout = 300;
        command = "${brightnessctl} -s; ${brightnessctl} set 0%";
        resumeCommand = "${brightnessctl} -r";
      }

      {
        timeout = 360;
        command = "${niri} msg action power-off-monitors";
      }

      {
        timeout = 600;
        command = "${loginctl} lock-session";
      }

      {
        timeout = 1800;
        command = "${systemctl} suspend";
      }
    ];
  };

  systemd.user.services.wayland-pipewire-idle-inhibit = {
    Unit = {
      Description = "Inhibit Wayland idling when media is played through pipewire";
      Documentation = "https://github.com/rafaelrc7/wayland-pipewire-idle-inhibit";
    };

    Install.WantedBy = [ config.wayland.systemd.target ];

    Service = {
      ExecStart = "${lib.getExe pkgs.wayland-pipewire-idle-inhibit}";
      Restart = "always";
      RestartSec = 10;
    };
  };
}
