{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.greeter.tuigreet.enable = lib.mkEnableOption "enable tuigreet greeter" // {
    default = true;
  };

  config = lib.mkIf config.modules.greeter.tuigreet.enable {
    services.greetd = {
      enable = true;
      vt = 7;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.greetd.tuigreet} -t -r --remember-user-session --user-menu --asterisks";
        };
      };
    };
  };
}
