{ config, pkgs, ... }:

{
  xdg.enable = true;

  xsession = {
    enable = true;

    initExtra = ''
      xset s 1800 dpms 0 1800 2100 &
      ${pkgs.feh}/bin/feh --no-fehbg --bg-fill /etc/nixos/other/bg.png &
    '';

    pointerCursor = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 32;
    };
  };
}
