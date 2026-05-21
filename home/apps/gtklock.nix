{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.lib.stylix.colors.withHashtag) base00 base08;
in
{
  services.swayidle.events.lock = "${lib.getExe pkgs.gtklock} -d -g ${config.gtk.gtk3.theme.name}";

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
        }

        window {
          background: url("${config.xdg.stateHome}/lockscreen.jpg") center / cover no-repeat ${base00};
          transition: 60ms;
        }

        #input-field {
          background-color: rgba(0, 0, 0, 0.5);
        }

        #time-box,
        #input-label,
        #error-label {
          text-shadow:
            0 0 0.1em rgba(0, 0, 0, 0.8),
            0 0 0.2em rgba(0, 0, 0, 0.4);
        }

        #error-label {
          color: ${base08};
        }

        #unlock-button:not(:disabled) {
          color: ${base00};
        }
      '';
  };
}
