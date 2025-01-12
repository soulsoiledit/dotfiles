{ config, lib, ... }:

let
  target = config.wayland.systemd.target;
  cfg = config.programs.wpaperd;
in
{
  programs.wpaperd = {
    enable = true;
    settings.any = {
      path = lib.mkForce "${config.home.homeDirectory}/pictures/wallpaper.png";
      # duration = "4h";
      # sorting = "random";
      transition.fade = { };
    };
  };

  systemd.user.services.wpaperd = {
    Install.WantedBy = [ target ];

    Unit = {
      Description = "wpaperd";
      PartOf = [ target ];
      After = [ target ];
    };

    Service = {
      ExecStart = "${lib.getExe' cfg.package "wpaperd"}";
      Restart = "always";
      RestartSec = "10";
    };
  };
}
