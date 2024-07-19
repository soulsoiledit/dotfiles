{
  pkgs,
  modulesPath,
  lib,
  ...
}:

{
  imports = [
    (import (modulesPath + "/programs/wayland/wayland-session.nix") {
      inherit lib pkgs;
      enableXWayland = false;
      enableWlrPortal = false;
    })
  ];

  environment.systemPackages = [ pkgs.niri ];

  services.displayManager.sessionPackages = [ pkgs.niri ];
}
