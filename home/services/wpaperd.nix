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
      Description = "wallpaper setting daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${lib.getExe' config.programs.wpaperd.package "wpaperd"}";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
