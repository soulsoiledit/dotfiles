{ config, ... }:

let
  inherit (config.lib.stylix.colors.withHashtag) base00 base01 base05;
  wlogout = config.programs.wlogout.package;
  icon = name: ''image(url("${wlogout}/share/wlogout/icons/${name}.png"))'';
in
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        "label" = "lock";
        "action" = "loginctl lock-session";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "sleep";
        "action" = "systemctl sleep";
        "text" = "Sleep";
        "keybind" = "s";
      }
      {
        "label" = "hibernate";
        "action" = "systemctl hibernate";
        "text" = "Hibernate";
        "keybind" = "h";
      }
      {
        "label" = "logout";
        "action" = "niri msg action quit --skip-confirmation";
        "text" = "Logout";
        "keybind" = "e";
      }
      {
        "label" = "reboot";
        "action" = "systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
      {
        "label" = "shutdown";
        "action" = "systemctl poweroff";
        "text" = "Shutdown";
        "keybind" = "p";
      }
    ];

    style =
      # css
      ''
        * {
          background-image: none;
          box-shadow: none;
        }

        window {
          background-color: rgba(0, 0, 0, 0.5);
        }

        button {
          border-radius: 0;
          border-color: ${base01};
          text-decoration-color: ${base05};
          color: ${base05};
          background-color: ${base00};
          border-style: solid;
          border-width: 1px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
        }

        button:active, button:hover {
          background-color: ${base01};
          outline-style: none;
        }

        #lock {
          background-image: ${icon "lock"};
        }

        #logout {
          background-image: ${icon "logout"};
        }

        #sleep {
          background-image: ${icon "suspend"};
        }

        #hibernate {
          background-image: ${icon "hibernate"};
        }

        #shutdown {
          background-image: ${icon "shutdown"};
        }

        #reboot {
          background-image: ${icon "reboot"};
        }
      '';
  };
}
