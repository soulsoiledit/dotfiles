{ lib, pkgs, ... }:

{
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
    catppuccin.enable = true;

    # plugins = with pkgs; [
    #   hyprland-protocols
    #   hyprland-autoname-workspaces
    #   hyprdim
    # ];

    settings =
      let
        gap = 2;

        gray = "$surface0";
        accent1 = "$mauve";
        accent2 = "$red";
      in
      {
        # set monitor preferences
        monitor = ",preferred,auto,auto";

        # set env variables
        env = [
          # hidpi scaling
          "GDK_SCALE,2"
          "STEAM_FORCE_DESKTOPUI_SCALING,1.5"
        ];

        # execute at launch
        exec-once = [
          "${lib.getExe pkgs.swaybg} -i ~/pictures/wallpaper"
          "${lib.getExe pkgs.wayland-pipewire-idle-inhibit}"
          "foot --server"
          "eww open bar --toggle"
          "[workspace 1 silent] firefox"
          "rog-control-center"
        ];

        general = {
          layout = "master";

          gaps_in = gap;
          gaps_out = gap * 2;
          border_size = 1;

          cursor_inactive_timeout = 4;

          "col.inactive_border" = "${gray}";
          "col.active_border" = "${accent1} ${accent2} 45deg";
        };

        misc = {
          disable_hyprland_logo = true;
        };

        group = {
          "col.border_inactive" = "${gray}";
          "col.border_active" = "${accent1} ${accent2} 45deg";

          "col.border_locked_inactive" = "${gray}";
          "col.border_locked_active" = "${accent2} ${accent1} 45deg";

          groupbar = {
            gradients = false;
            render_titles = false;
            "col.inactive" = "${gray}";
            "col.active" = "${accent1} ${accent2} 45deg";

            "col.locked_inactive" = "${gray}";
            "col.locked_active" = "${accent2} ${accent1} 45deg";
          };
        };

        layerrule = [ "blur, gtk-layer-shell" ];

        decoration = {
          rounding = 4;
          drop_shadow = false;
        };

        animations = {
          enabled = true;

          animation = [
            "windows, 1, 10, default"
            "windowsOut, 1, 5, default, popin 50%"

            "fade, 1, 10, default"
            "fadeOut, 1, 5, default"

            "border, 1, 10, default"
            "borderangle, 1, 10, default"
            "workspaces, 1, 10, default, slide"
          ];
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_invert = false;
        };

        master = {
          new_is_master = false;
        };

        xwayland = {
          force_zero_scaling = true;
        };

        misc = {
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
        };

        # window rules
        windowrulev2 = [
          # group all windows on workspace 2 that aren't floating
          "group set, workspace:2, floating:0"

          # float, center, & resize file picker dialog
          "float, title:^Open Files*$"
          "center, title:^Open Files*$"
          "size 65% 65%, title:^Open Files*$"

          # float & center vesktop startup
          "center, class:vesktop title:vesktop"

          # tile steam games
          "tile, class:steam_app_"
        ];

        # Keybindings
        "$mod" = "SUPER";

        # Programs
        "$screenshot" = "grimblast --freeze copysave area ~/pictures/screenshots/$(date +%F_%Hh%Mm%Ss).png";

        "$notify_kbd" = ''notify-send -c kbd-bright "Current keyboard led brightness" $(asusctl -k | rg ".* (\S+)" -r "\$1")'';
        "$notify_led" = ''notify-send -c kbd-mode "Current keyboard led mode:" "$(rg '\s+current_mode: (\S+),$' -r '$1' /etc/asusd/aura.ron)"'';

        "$notify_vol" = ''notify-send -c volume -i audio-volume-medium --hint=int:value:$(pamixer --get-volume) $(pamixer --get-volume)'';

        bind = [
          # Workspaces
          # Switch workspaces
          # TODO: generate these automatically
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"

          # Move active window to workspace
          "$mod SHIFT, 1, movetoworkspacesilent, 1"
          "$mod SHIFT, 2, movetoworkspacesilent, 2"
          "$mod SHIFT, 3, movetoworkspacesilent, 3"
          "$mod SHIFT, 4, movetoworkspacesilent, 4"
          "$mod SHIFT, 5, movetoworkspacesilent, 5"

          # scroll through existing workspaces with mouse

          # Move to last workspace
          "$mod, Tab, workspace, previous"

          # Navigation
          # Move focus
          "$mod, J, layoutmsg, cyclenext"
          "$mod, K, layoutmsg, cycleprev"
          "$mod, J, changegroupactive, f"
          "$mod, K, changegroupactive, b"
          "$mod, mouse_up, layoutmsg, cyclenext"
          "$mod, mouse_down, layoutmsg, cycleprev"
          "$mod, mouse_up, changegroupactive, f"
          "$mod, mouse_down, changegroupactive, b"

          # Swap windows
          "$mod, O, layoutmsg, swapwithmaster"
          "$mod SHIFT, J, layoutmsg, swapnext"
          "$mod SHIFT, K, layoutmsg, swapprev"

          # Change split ratio
          "$mod, H, splitratio, -0.05"
          "$mod, L, splitratio, +0.05"

          # Change number of master clients
          "$mod, m, layoutmsg, removemaster"
          "$mod, comma, layoutmsg, addmaster"

          # Windows
          "$mod, W, killactive,"
          "$mod, F, fullscreen, 1"
          "$mod, T, togglefloating, 1"

          # Groups
          "$mod, G, togglegroup"
          "$mod SHIFT, G, lockactivegroup, toggle"

          # Hyprland
          "$mod SHIFT, E, exit,"

          # Programs
          "$mod, Return, exec, footclient"
          "$mod, space, exec, fuzzel"

          # Bar
          "$mod, B, exec, eww open bar --toggle"
          "$mod, B, exec, pkill waybar"

          # Screenshot
          "$mod, S, exec, $screenshot"

          # Clipboard
          "$mod, p, exec, cliphist list | fuzzel -d --tabs 2 | cliphist decode | wl-copy"

          # Lock
          "$mod shift, l, exec, swaylock"

          # Media
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioPause, exec, playerctl play-pause"
          ",XF86AudioPrev, exec, playerctl previous"
          ",XF86AudioNext, exec, playerctl next"

          "$mod, 0, exec, playerctl play-pause"
          "$mod, minus, exec, playerctl previous"
          "$mod, equal, exec, playerctl next"

          # asus
          ",XF86Launch1, exec, rog-control-center"
          ",XF86Launch3, exec, asusctl led-mode --next-mode; $notify_led"
          ",XF86Launch4, exec, asusctl profile --next"
          ",XF86KbdBrightnessUp, exec, asusctl --next-kbd-bright; $notify_kbd"
          ",XF86KbdBrightnessDown, exec, asusctl --prev-kbd-bright; $notify_kbd"

          # notifications
          "ctrl, space, exec, makoctl dismiss"
          "ctrl shift, space, exec, makoctl dismiss --all"
          "ctrl shift, comma, exec, makoctl restore"
          "ctrl shift, period, exec, makoctl invoke"

          # brightness
          ",XF86MonBrightnessUp, exec, brightnessctl set 20%+"
          ",XF86MonBrightnessDown, exec, brightnessctl set 20%-"

          # volume
          ",XF86AudioMute, exec, pamixer --toggle-mute; $notify_vol"

          "SHIFT, XF86AudioRaiseVolume, exec, pamixer --increase 1; $notify_vol"
          "SHIFT, XF86AudioLowerVolume, exec, pamixer --decrease 1; $notify_vol"
        ];

        binde = [
          ",XF86AudioRaiseVolume, exec, pamixer --increase 5; $notify_vol"
          ",XF86AudioLowerVolume, exec, pamixer --decrease 5; $notify_vol"
        ];

        bindm = [
          # move/resize windows with mouse
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
  };
}
