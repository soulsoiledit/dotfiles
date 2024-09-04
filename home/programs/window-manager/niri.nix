{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
  ];

  options.opts.niri.enable = lib.mkEnableOption "enable niri window manager";

  config = lib.mkIf config.opts.niri.enable {
    home.packages = with pkgs; [
      libnotify
      grimblast
      wl-clipboard
      pamixer
      brightnessctl
      playerctl
    ];

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

        outputs."eDP-2" = {
          scale = 2;
          variable-refresh-rate = true;
          background-color = "#090b0f";
        };
        layout = {
          gaps = 4;

          struts = {
            left = 8;
            right = 8;
            top = 8;
            bottom = 8;
          };

          default-column-width.proportion = 0.5;
          preset-column-widths = [
            { proportion = 0.5; }
            { proportion = 1.0; }
          ];

          focus-ring = {
            enable = true;
            width = 1;
            active.gradient = {
              from = "#239382";
              to = "#976DA9";
            };
            inactive.color = "#808080";
          };

          border.enable = false;
        };

        environment = {
          # use native wayland when possible
          NIXOS_OZONE_WL = "1";

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
          { command = [ "wpaperd" ]; }
          { command = [ "wayland-pipewire-idle-inhibit" ]; }
          {
            command = [
              "wl-paste"
              "--primary"
              "--watch"
              "cliphist"
              "store"
            ];
          }
          {
            command = [
              "eww"
              "open"
              "bar"
            ];
          }
          { command = [ "xwayland-satellite" ]; }
          # { command = ["firefox"]; }
          # { command = ["spotify"]; }
          # { command = ["vesktop"]; }
          # { command = ["steam"]; }
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
            matches = [ { title = "(Firefox|Vesktop|Spotify|Steam)"; } ];
            default-column-width.proportion = 1.0;
          }

          # floating doesn't exist quite yet
          # /-window-rule {
          #   match title=r#"^Open File"#
          #   // float, center, resize
          # }
          #
          # /-window-rule {
          #   match title="vesktop" app-id="vesktop"
          # }

          # open games in fullscreen
          # {
          #   matches.title = "(steam_app_|Minecraft\*)";
          #   open-fullscreen = true;
          # }
        ];

        screenshot-path = "~/pictures/screenshots/%F_%Hh%Mm%Ss.png";

        binds = with config.lib.niri.actions; {
          "Mod+Shift+x".action = quit;

          # programs
          "Mod+Return".action.spawn = "wezterm";
          "Mod+Space".action.spawn = "fuzzel";
          "Mod+B".action.spawn = [
            "eww"
            "open"
            "bar"
            "--toggle"
          ];
          "Mod+Shift+L".action.spawn = "swaylock";
          "Mod+P".action.spawn = [
            "bash"
            "-c"
            "cliphist list | fuzzel -d --tabs 2 | cliphist decode | wl-copy"
          ];

          # TODO: update screenshot command
          "Mod+S".action = screenshot;
          # // "Mod+S" = { spawn "bash" "-c" "grimblast --freeze copysave area ~/pictures/screenshots/$(date +%F_%Hh%Mm%Ss).png"; }

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

          # brightness
          "XF86MonBrightnessUp" = {
            allow-when-locked = true;
            action.spawn = [
              "brightnessctl"
              "set"
              "20%+"
            ];
          };

          "XF86MonBrightnessDown" = {
            action.spawn = [
              "brightnessctl"
              "set"
              "20%-"
            ];
            allow-when-locked = true;
          };

          # TODO: readd osd
          # // volume
          "XF86AudioRaiseVolume" = {
            allow-when-locked = true;
            action.spawn = [
              "pamixer"
              "--increase"
              "5"
            ];
          };
          "XF86AudioLowerVolume" = {
            allow-when-locked = true;
            action.spawn = [
              "pamixer"
              "--decrease"
              "5"
            ];
          };
          "Shift+XF86AudioRaiseVolume" = {
            allow-when-locked = true;
            action.spawn = [
              "pamixer"
              "--increase"
              "1"
            ];
          };
          "Shift+XF86AudioLowerVolume" = {
            allow-when-locked = true;
            action.spawn = [
              "pamixer"
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

          # workspaces
          # not static
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;

          "Mod+Shift+1".action = move-window-to-workspace 1;
          "Mod+Shift+2".action = move-window-to-workspace 2;
          "Mod+Shift+3".action = move-window-to-workspace 3;
          "Mod+Shift+4".action = move-window-to-workspace 4;
          "Mod+Shift+5".action = move-window-to-workspace 5;

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
        # wayland.windowManager.hyprland = {
        #   settings = {
        #     # programs
        #     "$notify_vol" = ''notify-send -c osd -i audio-volume-medium --hint=int:value:$(pamixer --get-volume) $(pamixer --get-volume)'';
        #     # TODO: Better notifications for keyboard rgb, volume, mic, and screen backlight
        #     "$notify_kbd" = ''notify-send -c osd "Current keyboard led brightness" $(asusctl -k | rg ".* (\S+)" -r "\$1")'';
        #     "$notify_led" = ''notify-send -c osd "Current keyboard led mode:" "$(rg '\s+current_mode: (\S+),$' -r '$1' /etc/asusd/aura.ron)"'';
        #     # quick script to change power profiles
        #     "$notify_profile" = "case $(powerprofilesctl get) in 'performance') powerprofilesctl set balanced;; 'balanced') powerprofilesctl set power-saver;; 'power-saver') powerprofilesctl set performance;; esac; notify-send 'Current profile:' '$(powerprofilesctl get)'";
        #   };
        # };
      };
    };
  };
}