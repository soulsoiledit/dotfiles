{ config, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "nvim -R";
    GIT_PAGER = "nvim -R";
    MANPAGER = "nvim +Man!";

    "_JAVA_OPTIONS" = "-Djava.util.prefs.userRoot='${config.xdg.configHome}/java'";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";

    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    NIXOS_OZONE_WL = 1;
  };

  home.sessionPath = [
    "/home/soil/.local/bin/"
    "/home/soil/.local/share/npm/bin/"
    "/home/soil/.local/share/cargo/bin/"
  ];
}
