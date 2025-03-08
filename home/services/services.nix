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

  systemd.user.services = {
    cliphist.Unit.After = [ target ];
    cliphist-images.Unit.After = [ target ];
  };
}
