{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    fantasque-sans-mono
    (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    noto-fonts-cjk

    libnotify
    grimblast
    swaybg
    wl-clipboard

    # various utilities
    pamixer
    brightnessctl
    playerctl
  ];

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";

      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [
          "mauve"
          "pink"
          "red"
          "peach"
          "yellow"
          "green"
          "teal"
          "sky"
          "sapphire"
          "blue"
          "lavender"
        ];
        tweaks = [ "rimless" ];
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = config.colors.accent;
      };
    };
  };

  home.pointerCursor = {
    gtk.enable = true;

    size = 24;

    name = "Afterglow-Recolored-Catppuccin-Macchiato";

    package = pkgs.afterglow-cursors-recolored;
    # package = pkgs.bibata-cursors;
    # package = pkgs.rose-pine-cursor;
    # package = pkgs.qogir-icon-theme;
  };

  # disable ~/.icons/ generation
  home.file.".icons/${config.home.pointerCursor.name}".enable = lib.mkForce false;
  home.file.".icons/default/index.theme".enable = lib.mkForce false;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    # plugins = with pkgs; [
    #   hyprland-protocols
    #   hyprland-autoname-workspaces
    #   hyprdim
    # ];

    settings =
      let
        gap = 2;

        gray = "6c7086";
        accent1 = "cba6f7";
        accent2 = "f38ba8";
      in
      {
        # set monitor preferences
        monitor = ",preferred,auto,auto";

        # set env variables
        env = [
          # setup multi-gpu support; use iGPU as primary and dgpu as fallback
          "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"

          # hidpi scaling
          "GDK_SCALE,2"
          "STEAM_FORCE_DESKTOPUI_SCALING,1.5"
        ];

        # execute at launch
        exec-once = [
          "swaybg -i ~/pictures/wallpaper"
          "eww open bar --toggle"
          "foot --server"
          "firefox"
          "rog-control-center"
        ];

        general = {
          layout = "master";

          gaps_in = gap;
          gaps_out = gap * 2;
          border_size = 1;

          cursor_inactive_timeout = 4;

          "col.inactive_border" = "rgb(${gray})";
          "col.active_border" = "rgb(${accent1}) rgb(${accent2}) 45deg";
        };

        misc = {
          disable_hyprland_logo = true;
        };

        group = {
          "col.border_inactive" = "rgb(${gray})";
          "col.border_active" = "rgb(${accent1}) rgb(${accent2}) 45deg";

          groupbar = {
            gradients = false;
            render_titles = false;
            "col.inactive" = "rgb(${gray})";
            "col.active" = "rgb(${accent1}) rgb(${accent2}) 45deg";
          };
        };

        layerrule = [ "blur, gtk-layer-shell" ];

        decoration = {
          rounding = 4;
          drop_shadow = false;
        };

        animations = {
          enabled = true;
          # bezier = expoOut, 0.16, 1, 0.3, 1;

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

        # Input
        input = {
          # kb_file = ~/.local/share/xorg/xkb/gallium_angle
          scroll_method = "2fg";
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

        # Window rules
        windowrulev2 = [
          # Float file picker dialog
          "float, title:^(Open File)$"
          "center, title:^(Open File)$"
        ];

        # Keybindings
        "$mod" = "SUPER";

        # Programs
        "$screenshot" = "grimblast --freeze copysave area ~/pictures/screenshots/$(date +%F_%Hh%Mm%Ss).png";

        "$notify_kbd" = ''notify-send "Current keyboard led brightness" $(asusctl -k | rg ".* (\S+)" -r "\$1")'';
        "$notify_led" = ''notify-send "Current keyboard led mode:" "$(rg '\s+current_mode: (\S+),$' -r '$1' /etc/asusd/aura.ron)"'';

        "$notify_vol" = ''notify-send -c volume -i audio-volume-medium --hint=int:value:$(pamixer --get-volume) $(pamixer --get-volume)'';

        bind = [
          # Workspaces
          # Switch workspaces with mainMod + [0-4]
          # TODO: generate these automatically
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"

          # Move active window to a workspace with mod + SHIFT + [0-9]
          "$mod SHIFT, 1, movetoworkspacesilent, 1"
          "$mod SHIFT, 2, movetoworkspacesilent, 2"
          "$mod SHIFT, 3, movetoworkspacesilent, 3"
          "$mod SHIFT, 4, movetoworkspacesilent, 4"
          "$mod SHIFT, 5, movetoworkspacesilent, 5"

          # scroll through existing workspaces with mouse

          # Move to last workspace
          "$mod, Tab, workspace, previous"

          # Navigation
          # Move focus with mod + arrow keys
          "$mod, J, layoutmsg, cyclenext"
          "$mod, K, layoutmsg, cycleprev"
          "$mod, J, changegroupactive, b"
          "$mod, K, changegroupactive, f"
          "$mod, mouse_down, layoutmsg, cyclenext"
          "$mod, mouse_up, layoutmsg, cycleprev"

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

  # TODO: Add swayidle service
  # timers:
  # brightness decrement and restore
  # turn off screen
  # screenlock
  # suspend
  # events:
  # lock before suspend
  # run swaylock on lock
  # turn on display after resume

  services.cliphist.enable = true;

  services.gammastep = {
    enable = true;
    tray = true;

    # close enough
    latitude = "40";
    longitude = "-100";

    temperature = {
      day = 6000;
      night = 3500;
    };
  };
}
