{ config, ... }:

{
  services.wlsunset = {
    enable = true;

    latitude = "40";
    longitude = "-100";

    temperature = {
      day = 6250;
      night = 5500;
    };
  };

  systemd.user.services.wlsunset = {
    Unit = {
      Wants = [ config.services.wlsunset.systemdTarget ];
      After = [ config.services.wlsunset.systemdTarget ];
    };
  };
}
