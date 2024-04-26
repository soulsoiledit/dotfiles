{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    roboto
    roboto-serif
    roboto-mono
    noto-fonts-cjk
    fantasque-sans-mono
    (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    catppuccin = {
      enable = true;
      accent = "mauve";
      tweaks = [ "rimless" ];
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "mauve";
      };
    };
  };

  home.pointerCursor = {
    gtk.enable = true;

    size = 24;

    name = "BreezeX-RosePine-Linux";

    # package = pkgs.afterglow-cursors-recolored;
    # package = pkgs.bibata-cursors;
    package = pkgs.rose-pine-cursor;
    # package = pkgs.qogir-icon-theme;
  };

  # dont generate ~/.icons/
  home.file.".icons/${config.home.pointerCursor.name}".enable = lib.mkForce false;
  home.file.".icons/default/index.theme".enable = lib.mkForce false;

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
          {
            event = "after-resume";
            command = "${hyprctl} dispatch dpms on; ${brightnessctl} -r";
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
          {
            timeout = 900;
            command = "${loginctl} lock-session";
          }
          {
            timeout = 1800;
            command = "${systemctl} suspend";
          }
        ];
      };
  };
}
