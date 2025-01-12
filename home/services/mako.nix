{ config, ... }:

let
  icons = config.gtk.iconTheme;
in
{
  services = {
    mako = {
      enable = true;
      defaultTimeout = 5000;

      width = 250;
      borderRadius = 4;
      layer = "overlay";

      iconPath = "${icons.package}/share/icons/${icons.name}";
    };

    poweralertd.enable = true;
  };

  systemd.user.services.poweralertd = {
    Unit.After = [ config.wayland.systemd.target ];
  };
}
