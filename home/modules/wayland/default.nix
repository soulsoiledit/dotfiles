{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    river wlr-randr swaybg swaylock-effects
  ];

  home.sessionVariables.MOZ_ENABLE_WAYLAND = 1;

  xdg.configFile."river/init" = {
    source = ./init;
    executable = true;
  };

  xsession.windowManager.command = "/home/soil/.config/river/init";

  xsession = {
    importedVariables = [ "WAYLAND_DISPLAY" ];

    initExtra = ''
      ${pkgs.wlr-randr}/bin/wlr-randr --output eDP-1 --scale 2 &
      ${pkgs.swaybg}/bin/swaybg -i /etc/nixos/other/bg.png -m fill &
    '';

    scriptPath = ".config/waysession";
    profilePath = ".config/wayprofile";
  };

  rofi.package = pkgs.rofi-wayland;

  programs.foot = {
    enable = true;

    settings = {
      main.font = "UbuntuMono Nerd Font:size=12";
      mouse.hide-when-typing = "no";
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      bar = {
        layer = "bottom";
        position = "top";
        modules-left =  [ "river/tags" "wlr/taskbar" ];
        modules-center = [ "battery" "memory" "cpu" "temperature" ];
        modules-right = [ "network" "bluetooth" "pulseaudio" "backlight" "clock" "tray" ];

        "river/tags" = {
          tag-labels = [ "" "" "" "" "" "" "" "" "" ];
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
          format-icons = [" " " "];
        };

        "backlight" = {
          format = "{icon}";
          format-icons = [ " " " " " " " " "盛 " ];
        };

        "battery" = {
          format = "{capacity}% {icon}";
          format-icons = [" " " " " " " " " "];
        };

        "network" = {
          format-wifi = "{essid} ({signalStrength}%)  ";
          format-disconnected = "";
        };

        "tasklist" = {
          icon-size = 256;
          on-click = "activate";
          on-click-middle = "close";
        };
      };
    };

    style = ''
      * {
        /* `otf-font-awesome` is required to be installed for icons */
        font-family: UbuntuMono Nerd Font;
        font-size: 14px;
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
      
      window#waybar.termite {
          background-color: #3F3F3F;
      }
      
      window#waybar.chromium {
          background-color: #000000;
          border: none;
      }
      
      #workspaces button {
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
          padding: 0 5px;
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
      
      #language {
          background: #00b093;
          color: #740864;
          padding: 0 5px;
          margin: 0 5px;
          min-width: 16px;
      }
      
      #keyboard-state {
          background: #97e1ad;
          color: #000000;
          padding: 0 0px;
          margin: 0 5px;
          min-width: 16px;
      }
      
      #keyboard-state > label {
          padding: 0 5px;
      }
      
      #keyboard-state > label.locked {
          background: rgba(0, 0, 0, 0.2);
      }

      #tags button {
        font-size: 20px;
        padding: 0 0;
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
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -f"; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock-effects}/bin/swaylock -f --grace=5"; }
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
