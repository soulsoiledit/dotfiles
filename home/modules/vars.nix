{ config, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "nvim -R";
    GIT_PAGER = "nvim -R";
    MANPAGER = "nvim +Man!";

    "_JAVA_OPTIONS" = ''-Djava.util.prefs.userRoot="${config.xdg.configHome}/java"'';
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
    XCOMPOSEFILE = "${config.xdg.configHome}/X11/xcompose";
    XCOMPOSECACHE = "${config.xdg.configHome}/X11/xcompose";
    ERRFILE="${config.xdg.cacheHome}/X11/xsession-errors";
  };

  home.sessionPath = [
    "/home/soil/.config/emacs/bin"
    "/home/soil/.local/bin/"
    "/home/soil/.local/share/npm/bin/"
  ];
}
