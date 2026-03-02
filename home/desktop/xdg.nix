{ config, ... }:

let
  inherit (config.xdg)
    cacheHome
    configHome
    dataHome
    stateHome
    ;
in
{
  xdg.enable = true;

  home = {
    preferXdgDirectories = true;

    sessionVariables = {
      CARGO_HOME = "${dataHome}/cargo";
      RUSTUP_HOME = "${dataHome}/rustup";

      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${configHome}/java";
      GRADLE_USER_HOME = "${dataHome}/gradle";

      NPM_CONFIG_USERCONFIG = "${configHome}/npm/npmrc";
    };
  };

  home.pointerCursor.dotIcons.enable = false;

  xdg.configFile = {
    "npm/npmrc".text = ''
      prefix=${dataHome}/npm
      cache=${cacheHome}/npm
      init-module=${configHome}/npm/config/npm-init.js
      logs-dir=${stateHome}/npm/logs
    '';

    "pulse/client.conf".text = ''
      cookie-file = ${configHome}/pulse/cookie
    '';
  };

  xresources.path = "${configHome}/X11/xresources";
}
