{
  config,
  lib,
  pkgs,
  ...
}:

let
  enable = true;

  # adds quotes around each word
  spawn = str: ''spawn "${builtins.replaceStrings [ " " ] [ ''" "'' ] str}"'';
  volume = v: spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ ${v} -l 1.0";
in
lib.mkIf enable {
  home.packages = [ pkgs.niri ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.niri = {
      default = "gtk";
      "org.freedesktop.impl.portal.Inhibit" = "none";
    };
  };

  xdg.configFile."niri/config.kdl".text = # kdl
    ''
      input {
        focus-follows-mouse max-scroll-amount="10%"
        warp-mouse-to-focus
        touchpad {
          tap
          click-method "clickfinger"
        }
      }

      output "eDP-2" {
        scale 2
        background-color "transparent"
      }

      layout {
        gaps 8
        default-column-width { proportion 0.5; }
        preset-column-widths {
          proportion 0.5
          proportion 1.0
        }
        border { off; }
        focus-ring {
          width 1
          active-color "#${config.accent}"
        }
      }

      hotkey-overlay { skip-at-startup; }
      prefer-no-csd
      cursor { hide-after-inactive-ms 5000; }

      environment { DISPLAY ":0"; }
      screenshot-path "${config.home.homeDirectory}/pictures/screenshots/%Y-%m-%d_%H-%M-%S.png"

      workspace "1"
      workspace "2"
      workspace "3"
      workspace "4"
      workspace "5"

      gestures { hot-corners { off; }; }

      // workspaces
      binds {
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }

        Mod+Shift+1 { move-column-to-workspace focus=false 1; }
        Mod+Shift+2 { move-column-to-workspace focus=false 2; }
        Mod+Shift+3 { move-column-to-workspace focus=false 3; }
        Mod+Shift+4 { move-column-to-workspace focus=false 4; }
        Mod+Shift+5 { move-column-to-workspace focus=false 5; }

        Mod+Tab { focus-workspace-previous; }

        // windows
        Mod+W { close-window; }
        Mod+F { switch-preset-column-width; }

        Mod+N { focus-column-right-or-first; }
        Mod+E { focus-column-left-or-last; }

        Mod+Shift+N { move-column-right; }
        Mod+Shift+E { move-column-left; }

        Mod+M { set-column-width "-10%"; }
        Mod+I { set-column-width "+10%"; }

        // programs
        Mod+Return { spawn "footclient"; }
        Mod+Space { spawn "fuzzel"; }

        Mod+B { ${spawn "eww open bar --toggle"}; }
        Mod+S { screenshot show-pointer=false; }
        Mod+L { spawn "wlogout"; }
        // disables cache for fuzzel dmenu
        Mod+P { spawn "sh" "-c" "cliphist list | fuzzel --dmenu --with-nth 2 --cache /dev/null | cliphist decode | wl-copy"; }

        // volume
        XF86AudioRaiseVolume allow-when-locked=true { ${volume "5%+"}; }
        XF86AudioLowerVolume allow-when-locked=true { ${volume "5%-"}; }

        Shift+XF86AudioRaiseVolume { ${volume "1%+"}; }
        Shift+XF86AudioLowerVolume { ${volume "1%-"}; }

        XF86AudioMute allow-when-locked=true { ${spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"}; }
        XF86AudioMicMute allow-when-locked=true { ${spawn "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"}; }

        // media
        XF86AudioPlay allow-when-locked=true { ${spawn "playerctl play-pause"}; }
        XF86AudioPrev { ${spawn "playerctl previous"}; }
        XF86AudioNext { ${spawn "playerctl next"}; }

        Mod+0 allow-when-locked=true { ${spawn "playerctl play-pause"}; }
        Mod+Minus { ${spawn "playerctl previous"}; }
        Mod+Equal { ${spawn "playerctl next"}; }

        // brightness
        XF86MonBrightnessUp allow-when-locked=true { ${spawn "brightness_notify mon set 20%+"}; }
        XF86MonBrightnessDown allow-when-locked=true { ${spawn "brightness_notify mon set 20%-"}; }

        // keyboard
        XF86KbdBrightnessUp allow-when-locked=true { ${spawn "brightness_notify kbd set 1+"}; }
        XF86KbdBrightnessDown allow-when-locked=true { ${spawn "brightness_notify kbd set 1-"}; }

        // notifications
        Mod+Control+Space { ${spawn "makoctl dismiss --all"}; }
        Mod+Control+D { ${spawn "makoctl dismiss"}; }
        Mod+Control+Comma { ${spawn "makoctl restore"}; }
        Mod+Control+Period { ${spawn "makoctl invoke"}; }

        // profile
        XF86Launch4 { spawn "profile_notify"; }
      }

      layer-rule {
        match namespace="wpaperd-.*"
        place-within-backdrop true
      }

      window-rule {
        geometry-corner-radius 4.0
        clip-to-geometry true
      }

      window-rule {
        match app-id="firefox" at-startup=true
        open-on-workspace "1"
      }

      window-rule {
        match app-id="vesktop|spotify|steam" at-startup=true
        open-on-workspace "2"
      }

      window-rule {
        match app-id="firefox|vesktop|spotify|steam"
        default-column-width {
          proportion 1.0
        }
      }

      window-rule {
        match title="^Open Files?$"
        default-column-width {
          proportion 0.75
        }
        default-window-height {
          proportion 0.75
        }
        open-floating true
      }

      window-rule {
        match app-id="steam" title="^notificationtoasts_\\d+_desktop$"
        default-floating-position relative-to="bottom-right" x=8 y=8
      }
    '';
}
