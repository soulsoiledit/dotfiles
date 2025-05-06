{ config, ... }:

let
  iconTheme = config.gtk.iconTheme;
in
{
  services = {
    mako = {
      enable = true;
      settings = {
        default-timeout = 5000;

        width = 240;
        border-radius = 4;
        layer = "overlay";

        icon-path = "${iconTheme.package}/share/icons/${iconTheme.name}";
      };
    };

    poweralertd.enable = true;
  };
}
