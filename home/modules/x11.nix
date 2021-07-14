{ config, pkgs, ... }:

{
  xdg.enable = true;

  xsession = {
    enable = true;

    initExtra = ''
      xinput disable "AT Translated Set 2 keyboard" &
      xinput disable "Chicony USB 2.0 Camera: Chicony" &
      xset s 1800 dpms 0 1800 2100 &
      ${pkgs.feh}/bin/feh --no-fehbg --bg-fill /etc/nixos/other/bg.png &
      rm -rf .compose-cache .xsession-errors
    '';

    pointerCursor = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 32;
    };
  };
}
