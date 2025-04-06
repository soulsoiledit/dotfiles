{ config, ... }:

let
  iconTheme = config.gtk.iconTheme;
in
{
  services = {
    mako = {
      enable = true;
      defaultTimeout = 5000;

      width = 240;
      borderRadius = 4;
      layer = "overlay";

      iconPath = "${iconTheme.package}/share/icons/${iconTheme.name}";
    };

    poweralertd.enable = true;
  };
}
