{ config, ... }:

let
  home = config.home.homeDirectory;
in
{
  services.wpaperd = {
    enable = true;
    settings.any = {
      path = "${home}/pictures/wallpapers";
      duration = "4h";
      sorting = "random";
      transition.fade = { };
    };
  };
}
