{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.swayidle =
    let
      swaylock = lib.getExe pkgs.swaylock-effects;
      loginctl = lib.getExe' pkgs.systemd "loginctl";
      niri = lib.getExe' config.programs.niri.package "niri";
      # hyprctl = lib.getExe' config.wayland.windowManager.hyprland.finalPackage "hyprctl";
      brightnessctl = lib.getExe pkgs.brightnessctl;
      systemctl = lib.getExe' pkgs.systemd "systemctl";
    in
    {
      enable = true;

      events = [
        {
          event = "lock";
          command = "${swaylock}";
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
          timeout = 600;
          command = "${loginctl} lock-session";
        }
        {
          timeout = 720;
          command = "${niri} msg action power-off-monitors";
        }
        {
          timeout = 1800;
          command = "${systemctl} suspend";
        }
      ];
    };
}
