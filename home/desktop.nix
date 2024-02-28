{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    fantasque-sans-mono
    (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    noto-fonts-cjk

    libnotify
    grimblast
    swaybg
    wl-clipboard
    eww-wayland

    bc
    socat
    pamixer
    pavucontrol
  ];

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;

    # TODO: play around with non compact sizes
    theme = {
      name = "Catppuccin-Mocha-Compact-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
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
        size = "compact";
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  home.pointerCursor = {
    size = 24;
    # TODO: Try Vimix
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    gtk.enable = true;
  };

  programs.eww = {
    # enable = false;
    # package = pkgs.eww-wayland;
    # configDir = ./eww;
  };

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
          # setup multi-gpu support; use AMD iGPU only
          "WLR_DRM_DEVICES,/dev/dri/card1"

          # hint to UI frameworks to use wayland
          "NIXOS_OZONE_WL,1"
          "GDK_BACKEND,wayland,x11"
          "QT_QPA_PLATFORM,wayland;xcb"
          "SDL_VIDEODRIVER,wayland"
          "CLUTTER_BACKEND,wayland"

          # set XDG spec explicitly
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"
        ];

        # execute at launch
        exec-once = [
          "swaybg -i ~/code/dotfiles/extra/darkspace.jpg"
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

        layerrule = [
          # blur eww background
          "blur, gtk-layer-shell"
        ];

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

          touchpad = {
            # disable_while_typing = false;
          };
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
        "$volume_update" = ''eww update volume="$(~/.config/eww/scripts/volume.sh)"'';
        "$brightness_update" = "eww update brightness=$(~/.config/eww/scripts/brightness.sh)";

        "$notify_kbd" = ''notify-send "Current keyboard led brightness" $(asusctl -k | rg ".* (\S+)" -r "\$1")'';
        "$notify_led" = ''notify-send "Current keyboard led mode:" "$(rg '\s+current_mode: (\S+),$' -r '$1' /etc/asusd/aura.ron)"'';

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
          # "$mod, mouse_down, workspace, e+1"
          # "$mod, mouse_up, workspace, e-1"

          # Move to last workspace
          "$mod, Tab, workspace, previous"

          # Navigation
          # Move focus with mod + arrow keys
          "$mod, J, layoutmsg, cyclenext"
          "$mod, K, layoutmsg, cycleprev"
          "$mod, J, changegroupactive, b"
          "$mod, K, changegroupactive, f"

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
          ",XF86MonBrightnessUp, exec, brightnessctl set 20%+; $brightness_update"
          ",XF86MonBrightnessDown, exec, brightnessctl set 20%-; $brightness_update"

          # volume
          ",XF86AudioMute, exec, pamixer --toggle-mute; $volume_update"

          "SHIFT, XF86AudioRaiseVolume, exec, pamixer --increase 1; $volume_update"
          "SHIFT, XF86AudioLowerVolume, exec, pamixer --decrease 1; $volume_update"
        ];

        binde = [
          ",XF86AudioRaiseVolume, exec, pamixer --increase 5; $volume_update"
          ",XF86AudioLowerVolume, exec, pamixer --decrease 5; $volume_update"
        ];

        bindm = [
          # move/resize windows with mouse
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
  };

  # TODO: switch to ags?
  programs.waybar = {
    enable = true;
    settings = {
      tray = {
        layer = "top";
        position = "top";
        height = 25;
        width = 150;
        exclusive = true;
        margin-top = 0;

        modules-center = [ "tray" ];
        "tray" = {
          icon-size = 20;
          spacing = 5;
        };
      };
    };
    style =
      # css
      ''
        * {
          font-family: Fantasque Sans Mono;
          font-size: 10px;
        }

        #tray, #waybar {
          background: none;
          border-bottom: none;
        }
      '';
  };

  services.batsignal.enable = true;
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
