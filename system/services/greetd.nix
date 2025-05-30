{ lib, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    vt = 7;
    settings = {
      default_session = {
        command = builtins.concatStringsSep " " [
          (lib.getExe pkgs.greetd.tuigreet)
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
