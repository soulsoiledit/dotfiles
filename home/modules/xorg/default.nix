{ pkgs, fetchFromGithub, ... }:

let
  theme = (import ../../../other/colors.nix).theme;
in
{
  home.packages = with pkgs; [
    i3lock-color

    xclip
  ];

  xsession.windowManager.spectrwm = {
    enable = true;

    settings = {
      modkey = "Mod4";


      workspace_limit = 5;
      # focus_close		= previous
      # focus_close_wrap	= 1
      # focus_default		= last
      spawn_position = "first";

      maximize_hide_bar = true;
      # urgent_enable = true;

      # stack_mark_horizontal	= '[-]'
      # stack_mark_vertical	= '[|]'
      # stack_mark_max	= '[ ]'


      # Window Decoration
      border_width = 1;

      color_focus = rgb:b4/be/fe;
      color_unfocus = "rgb:31/32/44";

      region_padding = 20;
      tile_gap = 20;

      # Remove window border when bar is disabled and there is only one window in workspace
      disable_border = true;

      # Bar Settings
      bar_border_width = 5;
      "bar_border[1]" = "rgb:31/32/44";
      "bar_color[1]" = "rgb:31/32/44";
      "bar_font_color[1]" = "rgb:cd/d6/f4";

      bar_font = "FantasqueSansMono Nerd Font:size=10:antialias=true";
      bar_justify = "center";
      bar_format = "+12< +S";

      autorun = "ws[1]:firefox";
      # autorun = "ws[2]:discord";
      # autorun = "ws[2]:spotify";
      # autorun = "ws[1]:asus-notify";

      layout = "ws[2]:0:0:0:0:max";
      # layout = "ws[3]:0:0:0:0:max";

      keyboard_mapping = "/dev/null";
    };

    programs = {
      term = "alacritty";
      menu = "rofi -show drun";
      maximize2 = "sh -c 'xdotool key --clearmodifiers super+bracketleft; polybar-msg cmd toggle";

      brightness_up = "brightnessctl set 20%+";
      brightness_down = "brightnessctl set 20%-";

      lock = "i3lock-color -B 5";

      fan_profile = "asusctl profile - n";
      kbd_bright_up = "asusctl -n";
      kbd_bright_down = "asusctl -p";

      screenshot_area = "flameshot gui -s -c -p /home/soil/stuff/pictures/screenshots";
      screenshot_full = "flameshot full -c -p /home/soil/stuff/pictures/screenshots";

      clipboard = "sh -c 'CM_LAUNCHER=rofi CM_HISTLENGTH=5 clipmenu'";

      playerctl_pause = "playerctl play-pause";
      playerctl_prev = "playerctl previous";
      playerctl_next = "playerctl next";

      audio_raise = "pamixer -i 5";
      audio_lower = "pamixer -d";
      audio_mute = "pamixer -t";

      discord = "discord";
    };

    bindings = {

      bar_toggle = "MOD+b";

      cycle_layout = "MOD+Shift+space";

      maximize2 = "MOD+f";
      maximize_toggle = "MOD+bracketleft";
      float_toggle = "MOD+Shift+f";

      focus_main = "MOD+m";
      focus_next = "MOD+j";
      focus_prev = "MOD+k";
      focus_urgent = "MOD+u";

      lock = "MOD+Shift+l";
      # "XF86Sleep" = "i3lock-color -B && systemctl suspend";

      discord = "MOD+d";

      playerctl_pause = "XF86AudioPlay";
      # playerctl_pause = "XF86AudioPause";
      # playerctl_pause = "XF86AudioMedia";
      playerctl_prev = "XF86AudioPrev";
      playerctl_next = "XF86AudioNext";

      audio_raise = " XF86AudioRaiseVolume";
      audio_lower = " XF86AudioLowerVolume";
      audio_mute = " XF86AudioMute";

      master_add = " MOD+comma";
      master_del = " MOD+period";

      master_grow = "MOD+l";
      master_shrink = "MOD+h";
      menu = " MOD+space";

      mvws_1 = " MOD+Shift+1";
      mvws_2 = " MOD+Shift+2";
      mvws_3 = " MOD+Shift+3";
      mvws_4 = " MOD+Shift+4";
      mvws_5 = " MOD+Shift+5";

      quit = " MOD+Shift+q";
      restart = " MOD+Shift+r";

      screenshot_area = " MOD+s";
      screenshot_full = " MOD+Shift+s";

      swap_main = "MOD+Shift+Return";
      swap_next = "MOD+Shift+j";
      swap_prev = "MOD+Shift+k";

      term = "MOD+Return";

      wind_del = "MOD+w";

      ws_1 = "MOD+1";
      ws_2 = "MOD+2";
      ws_3 = "MOD+3";
      ws_4 = "MOD+4";
      ws_5 = "MOD+5";

      ws_prior = "MOD+Tab";

      brightness_up = "XF86MonBrightnessUp";
      brightness_down = "XF86MonBrightnessDown";

      fan_profile = "XF86Launch4";
      kbd_bright_up = "XF86KbdBrightnessUp";
      kbd_bright_down = "XF86KbdBrightnessDown";

      clipboard = "MOD+p";
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

        background = "#313244";
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
        label-urgent-foreground = "#f38ba8";

        label-empty = " ";
        label-empty-font = 1;
        label-empty-foreground = "#bac2de";

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
        label-muted-foreground = "#bac2de";
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
        format-low-foreground = "#222";
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

        format-disconnected-foreground = "#bac2de";
      };
    };
  };
}
