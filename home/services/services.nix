let
  systemdTarget = "graphical-session.target";
in
{
  services = {
    playerctld.enable = true;
    udiskie.enable = true;
    network-manager-applet.enable = true;
  };

  systemd.user.services.udiskie = {
    Unit = {
      Wants = [ systemdTarget ];
      After = [ systemdTarget ];
    };
  };

  systemd.user.services.network-manager-applet = {
    Unit = {
      Wants = [ systemdTarget ];
      After = [ systemdTarget ];
    };
  };
}
