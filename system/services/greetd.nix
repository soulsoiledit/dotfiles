{ lib, pkgs, ... }:

let
  tuigreet = lib.getExe pkgs.greetd.tuigreet;
in
{
  services.greetd = {
    enable = true;
    vt = 7;
    settings = {
      default_session = {
        command = lib.strings.concatStringsSep " " [
          tuigreet
          "--time"
          "--remember"
          "--remember-user-session"
          "--user-menu"
          "--asterisks"
        ];
      };
    };
  };
}
