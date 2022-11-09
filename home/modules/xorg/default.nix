{ pkgs, fetchFromGithub, ... }:

let
  theme = (import ../../../other/colors.nix).theme;
in
{
  home.packages = with pkgs; [
    i3lock-color

    xclip
  ];

  xsession.windowManager.awesome = {
    enable = true;
    luaModules = with pkgs; [ lua53Packages.vicious ];
    # noArgb = true;
  };

  services = {
    unclutter.enable = true;
    clipmenu.enable = true;
  };

  xsession = {
    initExtra = ''
      xset s 1800 dpms 0 1800 2100 &
      ${pkgs.feh}/bin/feh --no-fehbg --bg-fill /etc/nixos/other/bg_${theme.name}.png &

      firefox &
      discord &
      spotify &

      asus-notify &
    '';

    scriptPath = ".config/sx/sxrc";
    profilePath = ".config/sx/xprofile";
  };

  home.pointerCursor.x11.enable = true;
  home.pointerCursor.size = 48;

  xresources.path = ".config/sx/Xresources";

  services.picom = {
    enable = true;
    vSync = true;
    fade = true;
    fadeDelta = 5;
  };

  services.xidlehook = {
    enable = true;
    not-when-fullscreen = true;
    not-when-audio = true;

    environment = {
      "display" = "$(${pkgs.xorg.xrandr}/bin/xrandr | awk '/ primary/{print $1}')";
    };

    timers = [
      {
        delay = 300;
        command = ''${pkgs.brightnessctl}/bin/brightnessctl set 40%-'';
        canceller = ''${pkgs.brightnessctl}/bin/brightnessctl set 40%+'';
      }

      {
        delay = 360;
        command = ''${pkgs.i3lock-color}/bin/i3lock-color -B 5'';
        canceller = ''${pkgs.brightnessctl}/bin/brightnessctl set 40%+'';
      }
    ];
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;

    script = "polybar top &";
    config = {
      "bar/top" = {
        width = "99%";
        height = "2.5%";
        modules-center = [ "workspaces" "xwindow" ];
        modules-left = [ "date" "pulseaudio" "backlight" "network" ];
        modules-right = [ "temperature" "battery" "memory" "cpu" ];

        module-margin = "1";
        # wm-restack = "generic";
        override-redirect = true;

        enable-ipc = true;

        dpi = 216;

        padding = "5pt";

        background = "#00313244";
        foreground = "#cdd6f4";

        font-0 = "FantasqueSansMono Nerd Font:size=10;5";
        font-1 = "FantasqueSansMono Nerd Font:size=12;5";

        tray-position = "right";
        tray-maxsize = 128;
      };

      "module/date" = {
        type = "internal/date";
        internal = 10;
        date = "%a %m-%d";
        time = "%H:%M";
        label = " %date% %time%";
      };

      "module/workspaces" = {
        type = "internal/xworkspaces";
        reverse-scroll = true;

        label-active = " ";
        label-active-font = 1;

        label-occupied = " ";
        label-occupied-font = 1;

        label-urgent = "%icon%";
        label-urgent-font = 1;
        label-urgent-foreground = "#f38ba8";

        label-empty = " ";
        label-empty-font = 1;
        label-empty-foreground = "#a6adc8";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";

        format-volume = "<ramp-volume> <label-volume>";
        label-muted = "ﱝ %percentage%%";
        label-muted-foreground = "#a6adc8";
        ramp-volume-0 = "奄";
        ramp-volume-1 = "奔";
        ramp-volume-2 = "墳";
      };

      "module/backlight" = {
        type = "internal/backlight";
        card = "amdgpu_bl1";
        use-actual-brightness = true;

        format = "<ramp><label>";
        ramp-0 = " ";
        ramp-1 = " ";
        ramp-2 = " ";
        ramp-3 = " ";
        ramp-4 = " ";
        ramp-5 = " ";
      };
      "module/memory" = {
        type = "internal/memory";
        label = " %percentage_used%%";
        formate-warn-foreground = "#f38ba8";
      };

      "module/cpu" = {
        type = "internal/cpu";
        label = "  %percentage%%";
      };
      "module/battery" = {
        type = "internal/battery";
        poll-interval = 1;

        full-at = 80;
        format-full = "<ramp-capacity> <label-full>";

        label-charging = "%percentage%% %time% %consumption%";
        format-charging = "<animation-charging> <label-charging>";
        format-charging-foreground = "#a6e3a1";

        label-discharging = "%percentage%% %time% %consumption%";
        format-discharging = "<ramp-capacity> <label-discharging>";
        format-discharging-foreground = "#f9e2af";

        label-low = " %percentage%% %time% %consumption%";
        format-low = "<label-low>";
        format-low-foreground = "#1e1e2e";
        format-low-background = "#f38ba8";
        format-low-padding = 1;

        ramp-capacity-0 = "";
        ramp-capacity-1 = "";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
        ramp-capacity-5 = "";

        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";
      };

      "module/temperature" = {
        type = "internal/temperature";
        thermal-zone = 0;

        format = "<ramp><label>";
        format-warn = "<ramp><label>";
        base-temperature = 80;
        warn-temperature = 95;
        format-warn-foreground = "#f38ba8";

        ramp-0 = " ";
        ramp-1 = " ";
        ramp-2 = " ";
        ramp-3 = " ";
        ramp-4 = " ";
      };
      "module/network" = {
        type = "internal/network";
        interace = "wlan0";
        interface-type = "wireless";

        label-connected = "直 ";
        label-disconnected = "睊 ";

        format-disconnected-foreground = "#a6adc8";
      };
    };
  };
}
