{ pkgs, ... }:

let
  systemdTarget = "graphical-session.target";
in
{
  services = {
    mako = {
      enable = true;
      defaultTimeout = 5000;

      width = 250;
      borderRadius = 4;
      layer = "overlay";

      iconPath = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
    };

    # battery notifications
    # batsignal.enable = true;
    poweralertd.enable = true;
  };

  systemd.user.services.poweralertd = {
    Unit = {
      Wants = [ systemdTarget ];
      After = [ systemdTarget ];
    };
  };
}
