{pkgs, ...}: {
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    swaybg
    bc
    eww-wayland
    hyprpicker
    grimblast

    jq
    socat
    pamixer
    pavucontrol
  ];

  programs.eww = {
    enable = false;
    package = pkgs.eww-wayland;
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

    settings = {
      source = "extras.conf";

      # set monitor preferences
      monitor = ",preferred,auto,auto";

      # set env variables
      env = [
        # Setup multi-gpu support; use AMD iGPU by default
        "WLR_DRM_DEVICES,/dev/dri/card1"

        # Hint to UI frameworks to use wayland
        "XDG_SESSION_TYPE=wayland"
        "NIXOS_OZONE_WL=1"
        "GDK_BACKEND=wayland,x11"
        "QT_QPA_PLATFORM=wayland;xcb"
        "SDL_VIDEODRIVER=wayland"
        "CLUTTER_BACKEND=wayland"
      ];

      # execute at launch
      exec-once = [
        "swaybg -i /etc/nixos/other/spiderverse.jpg --mode fill"
        "eww daemon"
        "rog-control-center"
        "firefox"
      ];

      general = {
        layout = "master";

        gaps_in = 3;
        gaps_out = 6;
        border_size = 1;

        "col.inactive_border" = "rgba(6c7086ff)";
        "col.active_border" = "rgb(89dceb) rgb(a6e3a1) 45deg";

        cursor_inactive_timeout = 5;
      };

      misc = {
        disable_hyprland_logo = true;
        key_press_enables_dpms = true;
      };

      group = {
        "col.border_inactive" = "rgba(6c7086ff)";
        "col.border_active" = "rgb(89dceb) rgb(a6e3a1) 45deg";

        groupbar = {
          gradients = false;
          render_titles = false;
          "col.inactive" = "rgba(89b4fa6c)";
          "col.active" = "rgb(89b4fa) rgb(a6e3a1) 45deg";
        };
      };

      layerrule = [
        # Blur eww bar
        "blur, gtk-layer-shell"

        # Disable animations for slurp selection
        "noanim, selection"
      ];

      decoration = {
        rounding = 4;

        blur = {
          enabled = true;
          size = 6;
          passes = 2;
        };

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
        follow_mouse = 1;
        scroll_method = 2;

        touchpad = {
          disable_while_typing = false;
          natural_scroll = false;
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
      "$screenshot" = "grimblast --freeze copysave area ~/stuff/pictures/screenshots/$(date +%F_%Hh%Mm%Ss).png";
      "$volume_update" = "eww update volume=\"$(~/.config/eww/scripts/volume.sh)\"";
      "$brightness_update" = "eww update brightness=$(~/.config/eww/scripts/brightness.sh)";

      bind = [
        # Workspaces
        # Switch workspaces with mainMod + [0-4]
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

        # Mouse bindings
        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Move/resize windows with mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindowpixel"
        "$mod, mouse:273, resizewindowpixel"

        # Programs
        "$mod, Return, exec, alacritty msg create-window || alacritty"
        "$mod, space, exec, fuzzel"

        # Bar
        "$mod, B, exec, eww open example --toggle"
        "$mod, B, exec, pkill waybar"

        # Screenshot
        "$mod, S, exec, $screenshot"

        # Clipboard
        "$mod, P, exec, cliphist list | fuzzel -d --tabs 2 | cliphist decode | wl-copy"

        # Lock
        "$mod SHIFT, L, exec, swaylock"

        # Media
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86AudioNext, exec, playerctl next"

        # ASUS
        ",XF86Launch1, exec, rog-control-center"
        ",XF86Launch3, exec, asusctl led-mode --next-mode"
        ",XF86Launch4, exec, asusctl profile --next"
        ",XF86KbdBrightnessUp, exec, asusctl --next-kbd-bright"
        ",XF86KbdBrightnessDown, exec, asusctl --prev-kbd-bright"

        # Notifications
        "CTRL, space, exec, makoctl dismiss"
        "CTRL SHIFT, space, exec, makoctl dismiss --all"
        "CTRL SHIFT, comma, exec, makoctl restore"
        "CTRL SHIFT, period, exec, makoctl invoke"
      ];
    };

    extraConfig = /* python */ ''
      # Volume
      bind = ,XF86AudioMute, exec, pamixer --toggle-mute; $volume_update

      binde = ,XF86AudioRaiseVolume, exec, pamixer --increase 5; $volume_update
      binde = ,XF86AudioLowerVolume, exec, pamixer --decrease 5; $volume_update

      binde = SHIFT ,XF86AudioRaiseVolume, exec, pamixer --increase 1; $volume_update
      binde = SHIFT ,XF86AudioLowerVolume, exec, pamixer --decrease 1; $volume_update

      # Brightness
      binde = ,XF86MonBrightnessUp, exec, brightnessctl set 20%+; $brightness_update
      binde = ,XF86MonBrightnessDown, exec, brightnessctl set 20%-; $brightness_update
    '';
  };

  # programs.foot = {
  #   enable = true;
  #
  #   settings = {
  #     main.font = "FantasqueSansMono Nerd Font:size=16";
  #   };
  # };

  services.mako = {
    enable = true;
    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    borderColor = "#89b4fa";
    progressColor = "over #313244";
    borderRadius = 4;
    font = "FantasqueSansM Nerd Font 10";
    defaultTimeout = 5000;

    width = 250;

    extraConfig = ''
      [urgency=high]
      background-color=#89b4fa
      text-color=#1e1e2e
      border-color=#89b4fa
    '';
  };

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

        modules-center = ["tray"];
        "tray" = {
          icon-size = 20;
          spacing = 5;
        };
      };
    };
    style =
      /*
      css
      */
      ''
        * {
          font-family: FantasqueSansM Nerd Font, monospace;
          font-size: 10px;
        }

        #tray, #waybar {
          background: none;
          border-bottom: none;
        }
      '';
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      screenshots = true;
      effect-blur = "5x5";
      indicator = true;
      ignore-empty-password = true;
    };
  };

  services.cliphist.enable = true;

  services.gammastep = {
    enable = true;
    tray = true;
    latitude = "39";
    longitude = "-98";
    temperature = {
      day = 6000;
      night = 3500;
    };
  };
}
