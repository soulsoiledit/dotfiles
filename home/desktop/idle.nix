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
      hyprctl = lib.getExe' config.wayland.windowManager.hyprland.finalPackage "hyprctl";
      brightnessctl = lib.getExe pkgs.brightnessctl;
      systemctl = lib.getExe' pkgs.systemd "systemctl";
    in
    {
      # enable = true;

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
          timeout = 600;
          command = "${brightnessctl} -s; ${brightnessctl} set 0%";
          resumeCommand = "${brightnessctl} -r";
        }
        {
          timeout = 660;
          command = "${hyprctl} dispatch dpms off";
          resumeCommand = "${hyprctl} dispatch dpms on";
        }
        # {
        #   timeout = 900;
        #   command = "${loginctl} lock-session";
        # }
        {
          timeout = 900;
          command = "${systemctl} suspend";
        }
      ];
    };
}
