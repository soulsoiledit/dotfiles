{ config, ... }:

let
  target = config.wayland.systemd.target;
in
{
  xdg.configFile."cliphist/config".text = ''
    db-path ${config.xdg.stateHome}/cliphist/db
  '';

  services.cliphist.enable = true;

  systemd.user.services = {
    cliphist.Unit.After = [ target ];
    cliphist-images.Unit.After = [ target ];
  };
}
