{ lib, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    vt = 7;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} -t -r --remember-user-session --user-menu --asterisks --asterisks-char *";
      };
    };
  };
}
