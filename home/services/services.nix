{ config, ... }:

let
  target = config.wayland.systemd.target;
in
{
  services = {
    playerctld.enable = true;
    cliphist.enable = true;
    udiskie.enable = true;
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
  };

  systemd.user = {
    startServices = true;

    services = {
      udiskie.Unit.After = [ target ];
      cliphist.Unit.After = [ target ];
      cliphist-images.Unit.After = [ target ];
      network-manager-applet.Unit.After = [ target ];
      blueman-applet.Unit.After = [ target ];
    };
  };
}
