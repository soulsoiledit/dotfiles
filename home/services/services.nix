let
  systemdTarget = "graphical-session.target";
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
      udiskie.Unit.After = [ systemdTarget ];
      cliphist.Unit.After = [ systemdTarget ];
      cliphist-images.Unit.After = [ systemdTarget ];
      network-manager-applet.Unit.After = [ systemdTarget ];
      blueman-applet.Unit.After = [ systemdTarget ];
    };
  };
}
