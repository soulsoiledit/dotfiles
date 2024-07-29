{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:

{
  options = {
    opts.compositor.niri.enable = lib.mkEnableOption "enable niri compositor";
  };

  config = lib.mkIf config.opts.compositor.niri.enable (
    lib.mkMerge [
      (import (modulesPath + "/programs/wayland/wayland-session.nix") {
        inherit lib pkgs;
        enableXWayland = false;
        enableWlrPortal = false;
      })

      {
        environment.systemPackages = [ pkgs.niri ];
        services.displayManager.sessionPackages = [ pkgs.niri ];
      }
    ]
  );
}
