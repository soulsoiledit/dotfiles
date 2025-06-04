{
  config,
  lib,
  pkgs,
  ...
}:

let
  target = config.wayland.systemd.target;
  service = "xwayland-satellite.service";
in
{
  home.packages = [ pkgs.xwayland-satellite ];

  # set DISPLAY
  programs.niri.settings.environment.DISPLAY = ":0";
  systemd.user.settings.Manager.DefaultEnvironment.DISPLAY = ":0";

  # copy service
  xdg.configFile."systemd/user/${target}.wants/${service}".source =
    "${pkgs.xwayland-satellite}/share/systemd/user/${service}";

  # set dpi
  services.xsettingsd = {
    enable = true;
    settings."Xft/DPI" = 192 * 1024;
  };

  systemd.user.services.xsettingsd = {
    Service.Environment = [ "DISPLAY=:0" ];
    Install.WantedBy = lib.mkForce [ service ];
    Unit = {
      After = [ service ];
      Before = [ "xdg-desktop-autostart.target" ];
    };
  };
}
