{ config, pkgs, ... }:

{
  xdg.enable = true;

  xsession = {
    enable = true;

    initExtra = ''
      xset s 1800 dpms 0 1800 2100 &
      ${pkgs.feh}/bin/feh --no-fehbg --bg-fill /etc/nixos/other/bg.png &
    '';

    scriptPath = ".config/sx/sxrc";
    profilePath = ".config/sx/xprofile";
  };

  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    gtk.enable = true;
    x11.enable = true;
  };

  xresources.path = ".config/sx/Xresources";
}
