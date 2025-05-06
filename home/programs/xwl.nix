{
  config,
  lib,
  pkgs,
  ...
}:

let
  graphical-wants = "systemd/user/graphical-session.target.wants";
  xwl-sat = pkgs.xwayland-satellite;
  service = "xwayland-satellite.service";
  xrdb = lib.getExe pkgs.xorg.xrdb;
  display = ":0";
in
{
  home.packages = with pkgs; [
    xwayland-satellite
  ];

  # copy service
  xdg.configFile."${graphical-wants}/${service}" = {
    source = "${xwl-sat}/share/systemd/user/${service}";
  };

  # set display for xwayland-satellite
  programs.niri.settings = {
    environment.DISPLAY = display;
  };

  xresources.properties = {
    "Xft.dpi" = 192;
  };

  systemd.user.services.xwl-sat-xrdb = {
    Install.WantedBy = [ service ];

    Unit = {
      Description = "xrdb";
      After = [ service ];
      PartOf = [ service ];
    };

    Service = {
      Environment = [ ''DISPLAY=${display}'' ];
      ExecStart = "${xrdb} merge ${config.xresources.path}";
      Restart = "on-failure";
      RestartSec = "5";
    };
  };
}
