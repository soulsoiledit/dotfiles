{ pkgs, ... }:

{
  home.packages = with pkgs; [ brightnessctl scrot xclip acpi dunst 
  bsp-layout playerctl pamixer ];

#xdg.configFile."river/init" = {
#  source = ./init;
#  executable = true;
#};

  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
        eDP-1 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
    };

    settings = {
      border_width = 2;
      window_gap = 0;
      split_ratio = 0.5;
      borderless_monocle = true;
      gapless_monocle = true;
    };

    extraConfig = ''
      for desktop in $(bspc query --desktops --names); do
        bsp-layout set tall $desktop --master-size 0.5
      done
    '';
  };

  services.playerctld.enable = true;

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
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
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

        ws-icon-0 = "1; ";
        ws-icon-1 = "2; ";
        ws-icon-2 = "3; ";
        ws-icon-3 = "4; ";
        ws-icon-4 = "5; ";
        ws-icon-5 = "6; ";
        ws-icon-6 = "7; ";
        ws-icon-7 = "8; ";
        ws-icon-8 = "9; ";
        ws-icon-9 = "10; ";
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
