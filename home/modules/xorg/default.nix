{ pkgs, fetchFromGithub, ... }:

let
  theme = (import ../../../other/colors.nix).theme;
in {
  home.packages = with pkgs; [ 
    scrot xclip bsp-layout i3lock-color
  ];

  xsession.windowManager.bspwm = {
    enable = true;

    monitors = {
      eDP = [ "1" "2" "3" "4" "5" ]; 
      eDP-1 = [ "1" "2" "3" "4" "5" ]; 
    };

    settings = {
      border_width = 2;
      window_gap = 0;
      split_ratio = 0.5;
      borderless_monocle = true;
      gapless_monocle = true;
    };
  };

  services = {
    unclutter.enable = true;
    clipmenu.enable = true;
  };

  xsession = {
    initExtra = ''
      xset s 1800 dpms 0 1800 2100 &
      ${pkgs.feh}/bin/feh --no-fehbg --bg-fill /etc/nixos/other/bg_${theme.name}.png &
    '';

    scriptPath = ".config/sx/sxrc";
    profilePath = ".config/sx/xprofile";
  };

  home.pointerCursor.x11.enable = true;
  home.pointerCursor.size = 64;

  xresources.path = ".config/sx/Xresources";

  services.picom = {
    enable = true;
    # package = pkgs.picom.overrideAttrs (_: rec {
    #   pname = "picom-pijulius";
    #   version = "v9";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "pijulius";
    #     repo = "picom";
    #     rev = "982bb43e5d4116f1a37a0bde01c9bda0b88705b9";
    #     sha256 = "sha256-YiuLScDV9UfgI1MiYRtjgRkJ0VuA1TExATA2nJSJMhM=";
    #   };
    # });
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

      {
        delay = 600; 
        command = ''systemctl suspend'';
        canceller = ''${pkgs.brightnessctl}/bin/brightnessctl set 40%+'';
      }
    ];
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      # wm independent hotkeys
      "super + Return" = "alacritty";
      "super + @space" = "rofi -show drun";
      "super + d" = "discord";

      "XF86MonBrightness{Up,Down}" = "brightnessctl set 20%{+,-}";

      # power and lock
      "super + shift + l" = "i3lock-color -B 5";
      # "XF86Sleep" = "i3lock-color -B && systemctl suspend";

      # media
      "XF86Audio{Play,Pause,Media}" = "playerctl play-pause";
      "XF86Audio{Prev,Next}" = "playerctl {previous,next}";
      "XF86Audio{Raise,Lower}Volume" = "pamixer -{i,d} 5";
      "XF86AudioMute" = "pamixer -t";

      # bspwm hotkeys
      "super + shift + {q,r}" = "bspc {quit,wm -r; pkill -USR1 -x sxhkd}";
      "super + w" = "bspc node -c";
      "super + m" = "bspc desktop -l next";
      "super + shift + enter" = "bspc node -s biggest.window.local";

      # focus/swap
      "super + {_,shift} + {j,k}" = "bspc node {-f,-s} {next,prev}.local.!hidden.window";
      "super + {h,l}" = "bspc node biggest.window.local -z right {-,_}128 0";
      "super + {_,shift + }{1-5}" = "bspc {desktop -f,node -d} '^{1-5}'";
      "super + Tab" = "bspc desktop -f last";
      "super + {f,shift + f}" = "bspc node -t {~fullscreen,~floating}";
      
      # asus hotkeys
      "XF86Launch4" = "asusctl profile -n";
      "XF86KbdBrightness{Up,Down}" = "asusctl -{n,p}";

      # screenshot
      "super + s" = "${pkgs.flameshot}/bin/flameshot gui -s -c -p ~/stuff/pictures/screenshots";
      "super + shift + s" = "${pkgs.flameshot}/bin/flameshot full -c -p ~/stuff/pictures/screenshots";
      "super + p" = "CM_LAUNCHER=rofi CM_HISTLENGTH=5 ${pkgs.clipmenu}/bin/clipmenu";
    };
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
        wm-restack = "bspwm";

        dpi = 216;

        offset-x = "0.5%";
        offset-y = "0.5%";
        radius = "10";
        padding = "10pt";

        background = "#2e313d";

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
        type = "internal/bspwm";

        #label-dimmed = "%icon%";

        label-focused = " ";
        label-focused-font = 1;
        # label-focused-foreground = "#fff";

        label-occupied = " ";
        label-occupied-font = 1;
        # label-occupied-foreground = "#aaa";

        label-urgent = "%icon%";
        label-urgent-font = 1;
        label-urgent-foreground = "#f88";

        label-empty = " ";
        label-empty-font = 1;
        label-empty-foreground = "#aaa";

        ws-icon-0 = "1; ";
        ws-icon-1 = "2; ";
        ws-icon-2 = "3; ";
        ws-icon-3 = "4; ";
        ws-icon-4 = "5; ";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";

        format-volume = "<ramp-volume> <label-volume>";
        label-muted = "ﱝ %percentage%%";
        label-muted-foreground = "#aaa";
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
        formate-warn-foreground = "#f88";
      };

      "module/cpu" = {
        type = "internal/cpu";
        label = "  %percentage%%";
      };
      "module/battery" = {
        type = "internal/battery";
        poll-interval = 1;

        full-at = 80;

        label-low = " %percentage%%";
        format-low = "<label-low>";
        format-full = "<ramp-capacity> <label-full>";
        format-low-foreground = "#222";
        format-low-background = "#f88";
        format-low-padding = 1;

        format-discharging = "<ramp-capacity> <label-discharging>";
        format-charging = "<animation-charging> <label-charging>";
        format-discharging-foreground = "#ff8";
        format-charging-foreground = "#8c8";

        label-discharging = "%percentage%% %time% %consumption%";
        label-charging = "%percentage%% %time% %consumption%";

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
        format-warn-foreground = "#f88";

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

        format-disconnected-foreground = "#999";
      };
    };
  };
}
