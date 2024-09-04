{ config, ... }:

{
  home.sessionVariables = {
    PAGER = "bat";
    MANPAGER = "nvim +Man!";

    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    _JAVA_OPTIONS = ''-Djava.util.prefs.userRoot="${config.xdg.configHome}"/java'';
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.xdg.dataHome}/cargo/bin"
  ];
}
