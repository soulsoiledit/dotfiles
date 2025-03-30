{ config, ... }:

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
        "action" = "loginctl terminate-user $USER";
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
      with config.lib.stylix.colors;
      let
        iconPath = config.programs.wlogout.package + "/share/wlogout/icons";
      in
      # css
      ''
        * {
          background-image: none;
          box-shadow: none;
        }

        window {
          background-color: rgba(${base00-rgb-r}, ${base00-rgb-b}, ${base00-rgb-g}, 0.5);
        }

        button {
          border-radius: 0;
          border-color: ${withHashtag.base01};
          text-decoration-color: ${withHashtag.base05};
          color: ${withHashtag.base05};
          background-color: ${withHashtag.base00};
          border-style: solid;
          border-width: 1px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
        }

        button:active, button:hover {
          background-color: ${withHashtag.base01};
          outline-style: none;
        }

        #lock {
          background-image: image(url("${iconPath}/lock.png"));
        }

        #logout {
          background-image: image(url("${iconPath}/logout.png"));
        }

        #sleep {
          background-image: image(url("${iconPath}/suspend.png"));
        }

        #hibernate {
          background-image: image(url("${iconPath}/hibernate.png"));
        }

        #shutdown {
          background-image: image(url("${iconPath}/shutdown.png"));
        }

        #reboot {
          background-image: image(url("${iconPath}/reboot.png"));
        }
      '';
  };
}
