{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.hyprland.enable = lib.mkEnableOption "enable hyprland window manager";

  config = lib.mkIf config.modules.hyprland.enable {
    home.packages = with pkgs; [
      libnotify
      grimblast
      wl-clipboard
      pamixer
      brightnessctl
      playerctl
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;

      settings = {
        monitor = ", preferred, auto, 2";

        envd = [
          # scaling
          "GDK_SCALE,2"
          "STEAM_FORCE_DESKTOPUI_SCALING,1.5"
          "NIXOS_OZONE_WL,1"

          # qt theme
          "QT_QPA_PLATFORMTHEME,${config.qt.platformTheme.name}"
        ];

        exec-once = [
          "wpaperd"
          "${lib.getExe pkgs.wayland-pipewire-idle-inhibit}"
          # disabled currently
          # "firefox"
          # "spotify"
          # "vesktop"
          # "steam"
          "eww open bar --toggle"
          "wl-paste --primary --watch cliphist store"
        ];

        general = rec {
          border_size = 1;
          gaps_in = 2;
          gaps_out = gaps_in * 2;

          layout = "master";
        };

        xwayland = {
          force_zero_scaling = true;
        };

        master = {
          mfact = 0.6;
          new_status = "slave";
        };

        windowrulev2 = [
          # float, center, & resize file picker dialog
          "float, title:^Open File"
          "center, title:^Open File"
          "size 65% 65%, title:^Open File"

          # center vesktop startup
          "center, class:vesktop title:vesktop"

          # tile and fullscreen games
          "tile, class:(steam_app_|Minecraft\*)"
          "fullscreen, class:(steam_app_|Minecraft\*)"
        ];

        decoration = {
          rounding = 4;
          drop_shadow = false;
          blur = {
            enabled = false;
            xray = false;
          };
        };

        animations = {
          enabled = true;

          animation = [
            "fadeIn, 1, 10, default"
            "fadeOut, 1, 10, default"
          ];
        };

        group = {
          groupbar = {
            enabled = true;
            gradients = false;
            height = 50;
            render_titles = false;
          };
        };

        input = {
          touchpad = {
            disable_while_typing = false;
            natural_scroll = false;
            clickfinger_behavior = true;
            tap-to-click = true;
          };
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_invert = false;
        };

        cursor = {
          inactive_timeout = 4;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          font_family = "monospace";
          vrr = 1;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
          disable_autoreload = true;
          swallow_regex = "foot|wezterm";
          enable_swallow = true;

          new_window_takes_over_fullscreen = 1;
        };

        "$mod" = "super";

        # programs
        "$screenshot" = "grimblast --freeze copysave area ~/pictures/screenshots/$(date +%F_%Hh%Mm%Ss).png";
        "$notify_vol" = ''notify-send -c osd -i audio-volume-medium --hint=int:value:$(pamixer --get-volume) $(pamixer --get-volume)'';
        # TODO: Better notifications for keyboard rgb, volume, mic, and screen backlight
        "$notify_kbd" = ''notify-send -c osd "Current keyboard led brightness" $(asusctl -k | rg ".* (\S+)" -r "\$1")'';
        "$notify_led" = ''notify-send -c osd "Current keyboard led mode:" "$(rg '\s+current_mode: (\S+),$' -r '$1' /etc/asusd/aura.ron)"'';
        # quick script to change power profiles
        "$notify_profile" = "case $(powerprofilesctl get) in 'performance') powerprofilesctl set balanced;; 'balanced') powerprofilesctl set power-saver;; 'power-saver') powerprofilesctl set performance;; esac; notify-send 'Current profile:' '$(powerprofilesctl get)'";

        bind = [
          "$mod SHIFT, x, exit,"

          # programs
          "$mod, Return, exec, wezterm"
          "$mod, space, exec, fuzzel"
          "$mod, B, exec, eww open bar --toggle"
          "$mod shift, l, exec, swaylock"
          "$mod, S, exec, $screenshot"
          "$mod, p, exec, cliphist list | fuzzel -d --tabs 2 | cliphist decode | wl-copy"

          # power profiles
          ", XF86Launch4, exec, asusctl profile --next"

          # notifications
          "$mod ctrl, space, exec, makoctl dismiss --all"
          "$mod ctrl, d, exec, makoctl dismiss"
          "$mod ctrl, comma, exec, makoctl restore"
          "$mod ctrl, period, exec, makoctl invoke"

          # TODO: generate these automatically
          #
          # workspaces
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"

          "$mod SHIFT, 1, movetoworkspacesilent, 1"
          "$mod SHIFT, 2, movetoworkspacesilent, 2"
          "$mod SHIFT, 3, movetoworkspacesilent, 3"
          "$mod SHIFT, 4, movetoworkspacesilent, 4"
          "$mod SHIFT, 5, movetoworkspacesilent, 5"

          "$mod, tab, focuscurrentorlast"
          "$mod, u, focusurgentorlast"

          # windows
          "$mod, w, killactive,"
          "$mod, t, togglefloating, 1"
          "$mod, f, fullscreen, 1"
          "$mod, g, togglegroup"

          "$mod, n, changegroupactive, f"
          "$mod, e, changegroupactive, b"
          "$mod, n, layoutmsg, cyclenext"
          "$mod, e, layoutmsg, cycleprev"

          "$mod, o, layoutmsg, swapwithmaster"
          "$mod SHIFT, n, layoutmsg, swapnext"
          "$mod SHIFT, e, layoutmsg, swapprev"

          # layout
          "$mod, h, resizeactive, 0 10%"
          "$mod, comma, resizeactive, 0 -10%"

          "$mod, m, splitratio, -0.05"
          "$mod, i, splitratio, +0.05"
        ];

        bindl = [
          # brightness
          ",XF86MonBrightnessUp, exec, brightnessctl set 20%+"
          ",XF86MonBrightnessDown, exec, brightnessctl set 20%-"

          # media
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioPrev, exec, playerctl previous"
          ",XF86AudioNext, exec, playerctl next"
          "$mod, 0, exec, playerctl play-pause"
          "$mod, minus, exec, playerctl previous"
          "$mod, equal, exec, playerctl next"

          # volume
          ",XF86AudioMicMute, exec, pamixer --default-source -t"
          ",XF86AudioMute, exec, pamixer --toggle-mute; $notify_vol"

          "SHIFT, XF86AudioRaiseVolume, exec, pamixer --increase 1; $notify_vol"
          "SHIFT, XF86AudioLowerVolume, exec, pamixer --decrease 1; $notify_vol"
        ];

        bindel = [
          ",XF86AudioRaiseVolume, exec, pamixer --increase 5; $notify_vol"
          ",XF86AudioLowerVolume, exec, pamixer --decrease 5; $notify_vol"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
