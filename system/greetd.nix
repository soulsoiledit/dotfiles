{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings.default_session.command = lib.getExe pkgs.tuigreet;
  };

  environment.etc."tuigreet/config.toml".source =
    (pkgs.formats.toml { }).generate "tuigreet-config.toml"
      {
        display.show_time = true;

        remember = {
          username = true;
          session = true;
          user_session = true;
        };

        user_menu.enable = true;

        secret = {
          mode = "characters";
          characters = "*";
        };
      };
}
