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

    # battery notifications
    # batsignal.enable = true;
    poweralertd.enable = true;
  };

  systemd.user.services.poweralertd = {
    Unit.After = [ "graphical-session.target" ];
  };
}
