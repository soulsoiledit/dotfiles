{
  config,
  lib,
  pkgs,
  ...
}:

let
  dbus-run-session = lib.getExe' pkgs.dbus "dbus-run-session";
  hyprland = lib.getExe config.programs.hyprland.package;
  hyprland-conf = pkgs.writeText "greetd-hyprland.conf" ''
    bind = SUPER SHIFT, E, killactive,
    misc {
        disable_hyprland_logo = true
    }
    animations {
        enabled = false
    }
    exec-once = ${lib.getExe config.programs.regreet.package}; hyprctl dispatch exit
  '';
in
{
  environment.systemPackages = with pkgs; [
    (catppuccin-gtk.override { variant = "mocha"; })
    papirus-icon-theme
    rose-pine-cursor
  ];

  services.greetd.settings.default_session.command = "${dbus-run-session} ${hyprland} --config ${hyprland-conf} &> /dev/null";

  programs.regreet = {
    enable = true;

    settings = {
      # background = {};

      env = {
        XCURSOR_SIZE = "24";
      };

      GTK = {
        application_prefer_dark_theme = true;

        font_name = "DejaVu Sans 16";

        theme_name = "Catppuccin-Mocha-Standard-Blue-Dark";
        icon_theme_name = "Papirus-Dark";
        cursor_theme_name = "BreezeX-RosePine-Linux";
      };
    };
  };
}
