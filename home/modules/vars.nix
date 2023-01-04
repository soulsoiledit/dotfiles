{ config, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "nvim -R";
    GIT_PAGER = "nvim -R";
    MANPAGER = "nvim +Man!";

    "_JAVA_OPTIONS" = "-Djava.util.prefs.userRoot='${config.xdg.configHome}/java'";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";

    CARGO_HOME = "\"$XDG_DATA_HOME\"/cargo";
  };

  home.sessionPath = [
    "/home/soil/.local/bin/"
    "/home/soil/.local/share/npm/bin/"
  ];
}
