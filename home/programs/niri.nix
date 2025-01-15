{
  config,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
  ];

  home.packages = with pkgs; [
    xwayland-satellite
  ];

  systemd = {
    # add niri session target
    user.targets.niri-session = {
      Unit = {
        Description = "niri compositor session";
        Documentation = [ "man:systemd.special(7)" ];
        BindsTo = [ "graphical-session.target" ];
        Wants = [ "graphical-session-pre.target" ];
        After = [ "graphical-session-pre.target" ];
      };
    };

    # add tray target so apps startup correctly
    user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = [ "graphical-session-pre.target" ];
      };
    };
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      input = {
        touchpad = {
          tap = true;
          natural-scroll = false;
          scroll-method = "two-finger";
          click-method = "clickfinger";
        };

        warp-mouse-to-focus = true;
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "10%";
        };
      };

      cursor = {
        hide-after-inactive-ms = 5000;
      };

      outputs."BOE 0x0A1D Unknown" = {
        scale = 2;
        background-color = config.lib.stylix.colors.withHashtag.base00;
        variable-refresh-rate = true;
      };

      layout = {
        gaps = 8;

        default-column-width.proportion = 0.5;
        preset-column-widths = [
          { proportion = 0.5; }
          { proportion = 1.0; }
        ];

        focus-ring = {
          enable = true;
          width = 1;
          active.color = "#${config.opt.accent}";
          inactive.color = config.lib.stylix.colors.withHashtag.base03;
        };

        border.enable = false;
      };

      environment = {
        # set display for xwayland-satellite
        DISPLAY = ":0";
      };

      workspaces = {
        "1" = { };
        "2" = { };
        "3" = { };
        "4" = { };
        "5" = { };
      };

      spawn-at-startup = [
        { command = [ "xwayland-satellite" ]; }

        { command = [ "firefox" ]; }
        { command = [ "spotify" ]; }
        { command = [ "vesktop" ]; }
        { command = [ "steam" ]; }
      ];

      hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = true;

      window-rules = [
        # add rounded corner
        {
          geometry-corner-radius =
            let
              radius = 4.0;
            in
            {
              top-left = radius;
              top-right = radius;
              bottom-left = radius;
              bottom-right = radius;
            };
          clip-to-geometry = true;
        }

        # open with full width
        {
          matches = [ { title = "Firefox|Vesktop"; } ];
          default-column-width.proportion = 1.0;
        }

        {
          matches = [
            {
              title = "[vV]esktop|Spotify|Steam";
              at-startup = true;
            }
          ];

          open-on-workspace = "2";
        }

        # float and resize file pickers
        {
          matches = [ { title = "^Open Files?$"; } ];

          open-floating = true;
          default-column-width.proportion = 0.75;
          default-window-height.proportion = 0.75;
        }

        {
          matches = [
            {
              app-id = "steam";
              title = "^notificationtoasts_.*_desktop$";
            }
          ];

          default-floating-position = {
            x = 200;
            y = 100;
            relative-to = "bottom-right";
          };
        }
      ];

      screenshot-path = "~/pictures/screenshots/%Y-%m-%d_%H-%M-%S.png";

      binds =
        with config.lib.niri.actions;
        let
          move-column-to-workspace = ws: [
            "sh"
            "-c"
            "niri msg action move-column-to-workspace ${toString ws} && niri msg action focus-workspace-previous"
          ];
        in
        {
          # programs
          "Mod+Return".action.spawn = "footclient";
          "Mod+Space".action.spawn = "fuzzel";
          "Mod+S".action = screenshot;
          "Mod+B".action.spawn = [
            "eww"
            "open"
            "bar"
            "--toggle"
          ];
          "Mod+P".action.spawn = [
            "bash"
            "-c"
            "cliphist list | fuzzel -d --tabs 2 | cliphist decode | wl-copy"
          ];
          "Mod+L" = {
            allow-when-locked = true;
            action.spawn = "wlogout";
          };

          # notifications
          "Mod+Control+Space" = {
            allow-when-locked = true;
            action.spawn = [
              "makoctl"
              "dismiss"
              "--all"
            ];
          };
          "Mod+Control+D".action.spawn = [
            "makoctl"
            "dismiss"
          ];
          "Mod+Control+Comma".action.spawn = [
            "makoctl"
            "restore"
          ];
          "Mod+Control+Period".action.spawn = [
            "makoctl"
            "invoke"
          ];

          # brightness
          "XF86MonBrightnessUp" = {
            allow-when-locked = true;
            action.spawn = [
              "sh"
              "-c"
              "brightness_notify mon set 20%+"
            ];
          };

          "XF86MonBrightnessDown" = {
            allow-when-locked = true;
            action.spawn = [
              "sh"
              "-c"
              "brightness_notify mon set 20%-"
            ];
          };

          "XF86KbdBrightnessUp" = {
            allow-when-locked = true;
            action.spawn = [
              "sh"
              "-c"
              "brightness_notify kbd set 1+"
            ];
          };

          "XF86KbdBrightnessDown" = {
            allow-when-locked = true;
            action.spawn = [
              "sh"
              "-c"
              "brightness_notify kbd set 1-"
            ];
          };

          # volume
          "XF86AudioRaiseVolume" = {
            allow-when-locked = true;
            action.spawn = [
              "volume_notify"
              "--increase"
              "5"
            ];
          };
          "XF86AudioLowerVolume" = {
            allow-when-locked = true;
            action.spawn = [
              "volume_notify"
              "--decrease"
              "5"
            ];
          };
          "Shift+XF86AudioRaiseVolume" = {
            allow-when-locked = true;
            action.spawn = [
              "volume_notify"
              "--increase"
              "1"
            ];
          };
          "Shift+XF86AudioLowerVolume" = {
            allow-when-locked = true;
            action.spawn = [
              "volume_notify"
              "--decrease"
              "1"
            ];
          };

          "XF86AudioMute" = {
            allow-when-locked = true;
            action.spawn = [
              "pamixer"
              "--toggle-mute"
            ];
          };
          "XF86AudioMicMute" = {
            allow-when-locked = true;
            action.spawn = [
              "pamixer"
              "--default-source"
              "--toggle-mute"
            ];
          };

          # media
          "XF86AudioPlay" = {
            allow-when-locked = true;
            action.spawn = [
              "playerctl"
              "play-pause"
            ];
          };
          "XF86AudioPrev" = {
            allow-when-locked = true;
            action.spawn = [
              "playerctl"
              "previous"
            ];
          };
          "XF86AudioNext" = {
            allow-when-locked = true;
            action.spawn = [
              "playerctl"
              "next"
            ];
          };
          "Mod+0" = {
            allow-when-locked = true;
            action.spawn = [
              "playerctl"
              "play-pause"
            ];
          };
          "Mod+Minus" = {
            allow-when-locked = true;
            action.spawn = [
              "playerctl"
              "previous"
            ];
          };
          "Mod+Equal" = {
            allow-when-locked = true;
            action.spawn = [
              "playerctl"
              "next"
            ];
          };
          "XF86Launch4" = {
            allow-when-locked = true;
            action.spawn = "profile_notify";
          };

          # workspaces
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;

          "Mod+Shift+1".action.spawn = move-column-to-workspace 1;
          "Mod+Shift+2".action.spawn = move-column-to-workspace 2;
          "Mod+Shift+3".action.spawn = move-column-to-workspace 3;
          "Mod+Shift+4".action.spawn = move-column-to-workspace 4;
          "Mod+Shift+5".action.spawn = move-column-to-workspace 5;

          "Mod+H".action = focus-workspace-down;
          "Mod+Comma".action = focus-workspace-up;
          "Mod+Tab".action = focus-workspace-previous;

          # windows
          "Mod+W".action = close-window;
          "Mod+F".action = switch-preset-column-width;

          "Mod+N".action = focus-column-right-or-first;
          "Mod+E".action = focus-column-left-or-last;

          "Mod+Shift+N".action = move-column-right;
          "Mod+Shift+E".action = move-column-left;

          "Mod+M".action = set-column-width "-5%";
          "Mod+I".action = set-column-width "+5%";
        };
    };
  };
}
