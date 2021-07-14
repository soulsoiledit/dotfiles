{ config, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "nvim -R";
    GIT_PAGER = "nvim -R";
    MANPAGER = "nvim +Man!";
  };

  home.sessionPath = [
    "/home/soil/.config/emacs/bin"
    "/home/soil/.local/bin/"
    "/home/soil/.local/share/npm/bin/"
  ];
}
