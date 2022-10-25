{ config, pkgs, lib, ... }:

let
  theme = (import ../../../other/colors.nix).theme;
in
{
  home.packages = with pkgs; [
    river
    wlr-randr
    swaybg
    swaylock-effects
    wl-clipboard
  ];

  xdg.configFile."river/init" = {
    source = ./init;
    executable = true;
  };

  xsession = {
    windowManager.command = "/home/soil/.config/river/init";
    importedVariables = [ "WAYLAND_DISPLAY" ];

    initExtra = ''
      ${pkgs.swaybg}/bin/swaybg -i /etc/nixos/other/bg_${theme.name}.png -m fill &
    '';

    scriptPath = ".config/waysession";
    profilePath = ".config/wayprofile";
  };

  home.pointerCursor.size = 48;

  programs.firefox.profiles.soil = {
    settings."layout.css.devPixelsPerPx" = 2;
    userChrome = ''
      /* #tabbrowser-tabs, #navigator-toolbox, menuitem, menu, ... */
      * {
          font-size: 12px !important;
      }

      /* exception for badge on adblocker */
      .toolbarbutton-badge {
          font-size: 8px !important;
      }       
    '';
  };

  xdg.desktopEntries = {
    firefox = {
      name = "Firefox";
      exec = "env MOZ_ENABLE_WAYLAND=1 firefox %U";
    };

    spotify = {
      name = "Spotify";
      exec = "spotify --force-device-scale-factor=2 %U";
    };
  };


  programs.foot = {
    enable = true;

    settings = {
      main.font = "UbuntuMono Nerd Font:size=10";
      mouse.hide-when-typing = "yes";
    };
  };

  programs.rofi.package = pkgs.rofi-wayland;

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      bar = {
        layer = "bottom";
        position = "top";
        modules-left = [ "river/tags" ];
        modules-center = [ "battery" "memory" "cpu" "temperature" ];
        modules-right = [ "network" "bluetooth" "pulseaudio" "backlight" "clock" "tray" ];

        "river/tags" = {
          num-tags = 5;
          tag-labels = [ "" "" "" "" "" ];
        };

        "clock" = {
          format = "{:%a %m-%d %H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          interval = 15;
        };

        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = " ";
          scroll-step = 5;
          format-icons = [ " " " " ];
        };

        "backlight" = {
          format = "{icon}";
          format-icons = [ " " " " " " " " "盛 " ];
        };

        "battery" = {
          format = "{capacity}% {icon}";
          format-icons = [ " " " " " " " " " " ];
        };

        "network" = {
          format-wifi = "{essid} ({signalStrength}%)  ";
          format-disconnected = "";
        };

        "wlr/taskbar" = {
          icon-size = 48;
        };

        "tray" = {
          icon-size = 48;
        };
      };
    };

    style = ''
      * {
        /* `otf-font-awesome` is required to be installed for icons */
        font-size: 32px;
        font-family: UbuntuMono Nerd Font;
      }
      
      window#waybar {
          background-color: rgba(43, 48, 59, 0.5);
          border-bottom: 3px solid rgba(100, 114, 125, 0.5);
          color: #ffffff;
          transition-property: background-color;
          transition-duration: .5s;
      }
      
      window#waybar.hidden {
          opacity: 0.2;
      }
      
      /*
      window#waybar.empty {
          background-color: transparent;
      }

      window#waybar.solo {
          background-color: #FFFFFF;
      }
      */
      
      #workspaces button {
          font-size: 48px;
          padding: 0 5px;
          background-color: transparent;
          color: #ffffff;
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
          /* Avoid rounded borders under each workspace name */
          border: none;
          border-radius: 0;
      }
      
      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
          box-shadow: inset 0 -3px #ffffff;
      }
      
      #workspaces button.focused {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }
      
      #workspaces button.urgent {
          background-color: #eb4d4b;
      }
      
      #mode {
          background-color: #64727D;
          border-bottom: 3px solid #ffffff;
      }
      
      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #mpd {
          padding: 0 15px;
          color: #ffffff;
      }
      
      #window,
      #workspaces {
          margin: 0 4px;
      }
      
      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }
      
      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }
      
      #clock {
        background-color: #64727D;
      }
      
      #battery {
          background-color: #ffffff;
          color: #000000;
      }
      
      #battery.charging, #battery.plugged {
          color: #ffffff;
          background-color: #26A65B;
      }
      
      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }
      
      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
      
      label:focus {
          background-color: #000000;
      }
      
      #cpu {
          background-color: #2ecc71;
          color: #000000;
      }
      
      #memory {
          background-color: #9b59b6;
      }
      
      #disk {
          background-color: #964B00;
      }
      
      #backlight {
          background-color: #90b1b1;
      }
      
      #network {
          background-color: #2980b9;
      }
      
      #network.disconnected {
          background-color: #f53c3c;
      }
      
      #pulseaudio {
          background-color: #f1c40f;
          color: #000000;
      }
      
      #pulseaudio.muted {
          background-color: #90b1b1;
          color: #2a5c45;
      }
      
      #custom-media.custom-spotify {
          background-color: #66cc99;
      }
      
      #temperature {
        background-color: #f0932b;
      }
      
      #temperature.critical {
          background-color: #eb4d4b;
      }
      
      #tray {
          background-color: #2980b9;
      }
      
      #tray > .passive {
          -gtk-icon-effect: dim;
      }
      
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eb4d4b;
      }
      
      #tags button {
        padding: 0 10px;
        color: #aaaaaa;
      }

      #tags button.focused {
        color: #ffffff;
      }
    '';
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock -f";
      }
      {
        event = "before-sleep";
        command = "${pkgs.playerctl}/bin/playerctl pause";
      }
    ];
    timeouts = [
      {
        timeout = 590;
        command = "${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
        resumeCommand = "${pkgs.brightnessctl}/bin/brightness set 10%+";
      }
      {
        timeout = 600;
        command = "${pkgs.swaylock-effects}/bin/swaylock -f --grace=5";
      }
    ];
  };

  systemd.user.services.swayidle.Install = { WantedBy = [ "graphical-session.target" ]; };

  programs.swaylock.settings = {
    screenshots = true;
    effect-blur = "5x5";
    fade-in = 0.25;
    indicator = true;
    clock = true;
    ignore-empty-password = true;
  };
}
