{ config, ... }:

let
  iconTheme = config.gtk.iconTheme;
in
{
  services = {
    mako = {
      enable = true;
      defaultTimeout = 5000;

      width = 250;
      borderRadius = 4;
      layer = "overlay";

      iconPath = "${iconTheme.package}/share/icons/${iconTheme.name}";
    };

    poweralertd.enable = true;
  };

  systemd.user.services.poweralertd = {
    Unit.After = [ config.wayland.systemd.target ];
  };
}
