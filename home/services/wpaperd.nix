{ config, ... }:

{
  services.wpaperd = {
    enable = true;
    settings.any = {
      path = "${config.home.homeDirectory}/pictures/wallpapers";
      duration = "2h";
      sorting = "random";
      transition.fade = { };
    };
  };
}
