{
  config,
  inputs,
  pkgs,
  ...
}:

let
  radius = 4.0;
  move-column-to-workspace = ws: [
    "niri"
    "msg"
    "action"
    "move-column-to-workspace"
    (toString ws)
    "--focus"
    "false"
  ];
in
{
  imports = [ inputs.niri.homeModules.niri ];

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
        background-color = "transparent";
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
          active.color = "#${config.accent}";
          inactive.color = config.lib.stylix.colors.withHashtag.base03;
        };

        border.enable = false;
      };

      workspaces = {
        "1" = { };
        "2" = { };
        "3" = { };
        "4" = { };
        "5" = { };
      };

      spawn-at-startup = [
        { command = [ "firefox" ]; }
        { command = [ "spotify" ]; }
        { command = [ "vesktop" ]; }
        { command = [ "steam" ]; }
      ];

      hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = true;

      layer-rules = [
        {
          matches = [ { namespace = ''wpaperd-.*''; } ];
          place-within-backdrop = true;
        }
      ];

      window-rules = [
        # add rounded corner
        {
          geometry-corner-radius = {
            top-left = radius;
            top-right = radius;
            bottom-left = radius;
            bottom-right = radius;
          };
          clip-to-geometry = true;
        }

        # open with full width
        {
          matches = [ { app-id = ''firefox|vesktop|spotify|steam''; } ];
          default-column-width.proportion = 1.0;
        }

        {
          matches = [
            {
              app-id = ''firefox'';
              at-startup = true;
            }
          ];
          open-on-workspace = "1";
        }

        {
          matches = [ { app-id = ''vesktop|spotify|steam''; } ];
          open-on-workspace = "2";
        }

        # float and resize file pickers
        {
          matches = [ { title = ''^Open Files?$''; } ];

          open-floating = true;
          default-column-width.proportion = 0.75;
          default-window-height.proportion = 0.75;
        }

        # put steam notifs in a reasonable location
        {
          matches = [
            {
              app-id = ''steam'';
              title = ''^notificationtoasts_\d+_desktop$'';
            }
          ];

          default-floating-position = {
            x = 8;
            y = 8;
            relative-to = "bottom-right";
          };
        }
      ];

      screenshot-path = "~/pictures/screenshots/%Y-%m-%d_%H-%M-%S.png";

      gestures.hot-corners.enable = false;

      binds = with config.lib.niri.actions; {
        # programs
        "Mod+Return".action.spawn = "footclient";
        "Mod+Space".action.spawn = "fuzzel";
        "Mod+S".action = screenshot { show-pointer = false; };
        "Mod+B".action.spawn = [
          "sh"
          "-c"
          "eww open bar --toggle"
        ];
        "Mod+P".action.spawn = [
          "sh"
          "-c"
          "cliphist list | fuzzel -d --tabs 2 | cliphist decode | wl-copy"
        ];
        "Mod+L".action.spawn = "wlogout";

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
        "Shift+XF86AudioRaiseVolume".action.spawn = [
          "volume_notify"
          "--increase"
          "1"
        ];
        "Shift+XF86AudioLowerVolume".action.spawn = [
          "volume_notify"
          "--decrease"
          "1"
        ];

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
        "XF86AudioPrev".action.spawn = [
          "playerctl"
          "previous"
        ];
        "XF86AudioNext".action.spawn = [
          "playerctl"
          "next"
        ];
        "Mod+0" = {
          allow-when-locked = true;
          action.spawn = [
            "playerctl"
            "play-pause"
          ];
        };
        "Mod+Minus".action.spawn = [
          "playerctl"
          "previous"
        ];
        "Mod+Equal".action.spawn = [
          "playerctl"
          "next"
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

        # keyboard
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

        # notifications
        "Mod+Control+Space".action.spawn = [
          "makoctl"
          "dismiss"
          "--all"
        ];
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

        # profile
        "XF86Launch4".action.spawn = "profile_notify";

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
