{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    distrobox
    clipse
  ];

  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    catppuccin = {
      enable = true;
      icon.enable = false;
      cursor.enable = false;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
    style.catppuccin.enable = true;
  };

  home.pointerCursor = {
    gtk.enable = true;
    size = 24;
    name = "breeze_cursors";
    package = pkgs.kdePackages.breeze;
  };

  # dont generate ~/.icons/
  home.file.".icons/${config.home.pointerCursor.name}".enable = lib.mkForce false;
  home.file.".icons/default/index.theme".enable = lib.mkForce false;

  programs.wpaperd = {
    enable = true;
    settings.default = {
      path = "~/pictures/wallpapers/deer-sunset.jpg";
      mode = "center";
      # duration = "4h";
      # sorting = "random";
      transition.fade = { };
    };
  };

  services = {
    cliphist.enable = true;
    playerctld.enable = true;
    udiskie.enable = true;

    wlsunset = {
      enable = true;

      latitude = "40";
      longitude = "-100";

      temperature = {
        day = 6000;
        night = 4500;
      };
    };

    swayidle =
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
  };
}
