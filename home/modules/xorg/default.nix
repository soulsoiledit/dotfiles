{ pkgs, ... }:

{
  home.packages = with pkgs; [ 
    scrot xclip bsp-layout
  ];

  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
        eDP = [ "1" "2" "3" "4" "5" ];
    };

    settings = {
      border_width = 2;
      window_gap = 0;
      split_ratio = 0.5;
      borderless_monocle = true;
      gapless_monocle = true;
    };

    extraConfig = ''
      bsp-layout set tall 1 --master-size 0.5
      bsp-layout set tall 2 --master-size 0.5
      bsp-layout set tall 3 --master-size 0.5
      bsp-layout set tall 4 --master-size 0.5
      bsp-layout set tall 5 --master-size 0.5
    '';
  };

  services = {
    unclutter.enable = true;
    clipmenu.enable = true;
  };

  xsession = {
    initExtra = ''
      xset s 1800 dpms 0 1800 2100 &
      ${pkgs.feh}/bin/feh --no-fehbg --bg-fill /etc/nixos/other/bg.png &
      ${pkgs.xorg.xrandr}/bin/xrandr --dpi 216 &
    '';

    scriptPath = ".config/sx/sxrc";
    profilePath = ".config/sx/xprofile";
  };

  home.pointerCursor.x11.enable = true;
  xresources.path = ".config/sx/Xresources";

  services.picom = {
      enable = true;
      fade = true;
      vSync = true;
      fadeDelta = 5;
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      # wm independent hotkeys
      "super + Return" = "alacritty";
      "super + @space" = "rofi -show drun";

      # bspwm hotkeys
      "super + alt + {q,r}" = "bspc {quit,wm -r; kill -USR1 -x sxhkd}";
      "super + w" = "bspc node -c";
      "super + m" = "bspc desktop -l next";
      "super + g" = "bspc node -s biggest.window.local";

      # focus/swap
      "super + {j,k}" = "bspc node -f {next,prev}.local.!hidden.window";
      "super + {_,shift + }{1-5}" = "bspc {desktop -f,node -d} '^{1-5}'";
      "super + {grave,Tab}" = "bspc {node,desktop} -f last";
      "super + {f,shift + f}" = "bspc node -t {~fullscreen,~floating}";

      # media
      "XF86Audio{Play,Pause,Media}" = "playerctl play-pause";
      "XF86Audio{Prev,Next}" = "playerctl {previous,next}";
      "XF86Audio{Raise,Lower}Volume" = "pamixer -{i,d} 5";
      "XF86AudioMute" = "pamixer -t";
    };
  };


  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;

    script = "polybar top &";
    config = {
      "bar/top" = {
        width = "100%";
        height = "3%";
        modules-center = [ "xwindow" "workspaces" ];
        modules-left = [ "date" "pulseaudio" "backlight" ];
        modules-right = [ "temperature" "battery" "memory" ];

        module-margin = 2;
        wm-restack = "bspwm";

        dpi-x = 216;
        dpi-y = 216;

        font-0 = "UbuntuMono Nerd Font:size=14";
      };

      "module/date" = {
        type = "internal/date";
        internal = 10;
        date = "%a %m-%d";
        time = "%H:%M";
        label = "%date% %time%";
      };

      "module/workspaces" = {
        type = "internal/bspwm";

        label-dimmed = "%icon%";
        label-focused = "%icon%";
        label-occupied = "%icon%";
        label-occupied-foreground = "#aaaaaa";
        label-urgent = "%icon%";
        label-urgent-foreground = "#ff0000";
        label-empty = "";

        ws-icon-9 = "1; ";
        ws-icon-0 = "2; ";
        ws-icon-1 = "3; ";
        ws-icon-2 = "4; ";
        ws-icon-3 = "5; ";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
      };
      "module/xwindow" = {
        type = "internal/xwindow";
      };
      "module/backlight" = {
        type = "internal/backlight";
        card = "amdgpu_bl0";
      };
      "module/memory" = {
        type = "internal/memory";
      };
      "module/battery" = {
        type = "internal/battery";
      };
      "module/temperature" = {
        type = "internal/temperature";
        thermal-zone = 0;
      };
    };
  };
}
