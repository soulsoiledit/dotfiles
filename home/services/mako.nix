{ config, ... }:

{
  services = {
    mako = {
      enable = true;
      defaultTimeout = 5000;

      width = 250;
      borderRadius = 4;
      layer = "overlay";

      iconPath = "${config.gtk.iconTheme.package}/share/icons/${config.gtk.iconTheme.name}";
    };

    poweralertd.enable = true;
  };

  systemd.user.services.poweralertd = {
    Unit.After = [ config.wayland.systemd.target ];
  };
}
