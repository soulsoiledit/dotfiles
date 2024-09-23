{ config, lib, ... }:

{
  programs.wpaperd = {
    enable = true;
    settings.any = {
      path = lib.mkForce "${config.home.homeDirectory}/pictures/wallpaper.png";
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
