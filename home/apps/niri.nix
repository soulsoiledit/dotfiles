{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) recursiveUpdate;

  noFocus = a: {
    _args = [ a ];
    _props.focus = false;
  };
  allowWhenLocked = a: recursiveUpdate a { _props.allow-when-locked = true; };
  noRepeat = a: recursiveUpdate a { _props.repeat = false; };

  volume = v: "wpctl set-volume @DEFAULT_AUDIO_SINK@ -l 1.0 ${v}";
in
{
  home.packages = [
    pkgs.niri
    pkgs.xwayland-satellite
  ];

  xdg.configFile."niri/config.kdl".text = lib.hm.generators.toKDL { } {
    input = {
      focus-follows-mouse._props.max-scroll-amount = "10%";
      warp-mouse-to-focus = { };
      touchpad = {
        tap = { };
        click-method = "clickfinger";
      };
    };

    gestures.hot-corners.off = { };

    layout = {
      background-color = "transparent";
      default-column-width.proportion = 0.5;
      preset-column-widths._children = [
        { proportion = 0.5; }
        { proportion = 1.0; }
      ];

      gaps = 8;
      border.off = { };
      focus-ring = {
        width = 1;
        active-color = config.lib.stylix.colors.withHashtag.${config.accent};
      };
    };

    prefer-no-csd = { };
    hotkey-overlay.skip-at-startup = { };
    cursor.hide-after-inactive-ms = 1000;
    screenshot-path = "${config.xdg.cacheHome}/screenshots/%Y-%m-%d_%H-%M-%S.png";

    binds = {
      # workspaces
      "Mod+1".focus-workspace = 1;
      "Mod+2".focus-workspace = 2;
      "Mod+3".focus-workspace = 3;
      "Mod+4".focus-workspace = 4;
      "Mod+5".focus-workspace = 5;

      "Mod+Shift+1".move-column-to-workspace = noFocus 1;
      "Mod+Shift+2".move-column-to-workspace = noFocus 2;
      "Mod+Shift+3".move-column-to-workspace = noFocus 3;
      "Mod+Shift+4".move-column-to-workspace = noFocus 4;
      "Mod+Shift+5".move-column-to-workspace = noFocus 5;

      "Mod+L".focus-workspace-down = { };
      "Mod+U".focus-workspace-up = { };

      "Mod+Shift+L".move-workspace-down = { };
      "Mod+Shift+U".move-workspace-up = { };

      "Mod+Ctrl+L".move-column-to-workspace-down = { };
      "Mod+Ctrl+U".move-column-to-workspace-up = { };

      "Mod+Tab".focus-workspace-previous = { };

      # windows
      "Mod+W".close-window = { };
      "Mod+F".switch-preset-column-width = { };

      "Mod+N".focus-column-right-or-first = { };
      "Mod+E".focus-column-left-or-last = { };

      "Mod+Shift+N".move-column-right = { };
      "Mod+Shift+E".move-column-left = { };

      "Mod+M".set-column-width = "-10%";
      "Mod+I".set-column-width = "+10%";

      # programs
      "Mod+Return" = noRepeat { spawn = "footclient"; };
      "Mod+Space".spawn-sh = "vicinae open";

      # backup
      "Mod+Ctrl+Shift+Return" = noRepeat { spawn = "foot"; };
      "Mod+Ctrl+Shift+L" = allowWhenLocked (noRepeat {
        spawn-sh = "loginctl lock-session";
      });

      "Mod+B".spawn-sh = "eww open bar --toggle";
      "Mod+S".screenshot._props.show-pointer = false;

      # volume
      XF86AudioRaiseVolume = allowWhenLocked { spawn-sh = volume "5%+"; };
      XF86AudioLowerVolume = allowWhenLocked { spawn-sh = volume "5%-"; };

      XF86AudioMute = allowWhenLocked { spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; };
      XF86AudioMicMute = allowWhenLocked { spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; };

      # media
      XF86AudioPlay = allowWhenLocked { spawn-sh = "playerctl play-pause"; };
      XF86AudioPrev.spawn-sh = "playerctl previous";
      XF86AudioNext.spawn-sh = "playerctl next";

      "Mod+0" = allowWhenLocked { spawn-sh = "playerctl play-pause"; };
      "Mod+Minus".spawn-sh = "playerctl previous";
      "Mod+Equal".spawn-sh = "playerctl next";

      # brightness
      XF86MonBrightnessUp = allowWhenLocked { spawn-sh = "brightnessctl set 20%+"; };
      XF86MonBrightnessDown = allowWhenLocked { spawn-sh = "brightnessctl set 20%-"; };

      # keyboard
      XF86KbdBrightnessUp = allowWhenLocked { spawn-sh = "brightnessctl -d *kbd* set 1+"; };
      XF86KbdBrightnessDown = allowWhenLocked { spawn-sh = "brightnessctl -d *kbd* set 1-"; };

      # notifications
      "Mod+K".spawn-sh = "makoctl dismiss";
      "Mod+Shift+K".spawn-sh = "makoctl dismiss --all";
      "Mod+Ctrl+K".spawn-sh = "makoctl invoke";
      "Mod+Ctrl+Shift+K".spawn-sh = "makoctl restore";
    };

    debug.force-disable-connectors-on-resume = true;

    _children = [
      {
        output = {
          _args = [ "eDP-2" ];
          scale = 1.75;
        };
      }

      { workspace = "1"; }
      { workspace = "2"; }
      { workspace = "3"; }
      { workspace = "4"; }
      { workspace = "5"; }

      {
        layer-rule = {
          match._props = {
            layer = "background";
            namespace = "quickshell";
          };
          place-within-backdrop = true;
        };
      }

      {
        window-rule = {
          geometry-corner-radius = 4.0;
          clip-to-geometry = true;
        };
      }

      {
        window-rule = {
          match._props.app-id = "firefox|vesktop|steam";
          default-column-width.proportion = 1.0;
        };
      }

      {
        window-rule = {
          match._props.app-id = "xdg-desktop-portal";
          default-column-width.proportion = 0.75;
          default-window-height.proportion = 0.75;
        };
      }

      {
        window-rule = {
          match._props = {
            app-id = "steam";
            title = "^notificationtoasts_\\\\d+_desktop$";
          };
          default-floating-position._props = {
            x = 8;
            y = 8;
            relative-to = "bottom-right";
          };
        };
      }
    ];
  };
}
