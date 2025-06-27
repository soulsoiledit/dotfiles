{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.wpaperd = {
    enable = true;
    settings.any = {
      path = "${config.home.homeDirectory}/pictures/wallpapers";
      duration = "2h";
      sorting = "random";
      transition.fade = { };
      exec = pkgs.writeShellScript "blur-wallpaper" ''
        ${lib.getExe pkgs.vips} gaussblur $2 ${config.xdg.stateHome}/lockscreen.jpg 16
      '';
    };
  };
}
