{ config, ... }:

let
  inherit (config.gtk) iconTheme;
in
{
  services.mako = {
    enable = true;
    settings = {
      width = 240;
      border-size = 1;
      border-radius = 4;
      layer = "overlay";

      icon-path = "${iconTheme.package}/share/icons/${iconTheme.name}";

      default-timeout = 5000;
      "urgency=low".default-timeout = 2500;
      "urgency=critical".default-timeout = 0;
    };

    extraConfig = # ini
      ''
        [category=osd]
        default-timeout=1250
      '';
  };
}
