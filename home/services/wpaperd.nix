{ config, lib, ... }:

{
  programs.wpaperd = {
    enable = true;
    settings.default = {
      path = "~/pictures/wallpapers/astro-jelly.jpg";
      mode = "center";
      # duration = "4h";
      # sorting = "random";
      transition.fade = { };
    };
  };

  systemd.user.services.wpaperd = {
    Unit = {
      Description = "wpaperd";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };

    Service = {
      Type = "exec";
      ExecStart = "${lib.getExe' config.programs.wpaperd.package "wpaperd"}";
      Restart = "on-failure";
    };
  };
}
