{ config, ... }:

{
  services = {
    cliphist.enable = true;
    easyeffects.enable = true;
    playerctld.enable = true;

    network-manager-applet.enable = true;
    blueman-applet.enable = true;
    udiskie.enable = true;
  };

  xdg.configFile."cliphist/config".text = ''
    db-path ${config.xdg.stateHome}/cliphist/db
  '';
}
