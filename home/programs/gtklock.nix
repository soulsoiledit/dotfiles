{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.lib.stylix.colors.withHashtag) base00 base05;
in
{
  systemd.user.services.lockscreen = {
    Service.ExecStart = lib.getExe pkgs.gtklock;
  };

  xdg.configFile = {
    "gtklock/config.ini".text =
      # ini
      ''
        [main]
        time-format = %X
      '';

    "gtklock/style.css".text =
      # css
      ''
        * {
          font-family: sans-serif;
          transition: 60ms;
        }

        window {
          background-image: url("${config.xdg.cacheHome}/lockscreen.jpg");
          background-size: cover;
          background-position: center;
          background-repeat: no-repeat;
          background-color: ${base00};
        }

        #window-box {
          padding: 5em;
          border-radius: 2em;
          color: ${base05};
        }

        #input-field {
          background-color: rgba(0, 0, 0, 0.5);
        }

        #time-box,
        #input-label,
        #error-label {
          text-shadow: 1px 1px 4px black;
        }

        #error-label {
          color: #e94646;
        }

        #unlock-button {
          color: ${base00};
        }

        #unlock-button:disabled {
          background-color: ${base00};
          color: #${config.accent};
        }
      '';
  };
}
