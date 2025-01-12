{ config, lib, ... }:

let
  home = config.home.homeDirectory;
  target = config.wayland.systemd.target;
  cfg = config.programs.wpaperd;
in
{
  programs.wpaperd = {
    enable = true;
    settings.any = {
      path = lib.mkForce "${home}/pictures/wallpapers";
      duration = "4h";
      sorting = "random";
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
    };
  };
}
