{ config, pkgs, ... }:

# TODO
# minimize bar info
# center block?
#   window name?
#   song name

# add alternating bar background colors?
# window border?
# window transparency?

# xmonad?
# awesome?
# bspwm
# penrose?
# stumpwm?

# emacs
# kakoune

{
  programs.home-manager.enable = true;

  home = {
    username = "soil";
    homeDirectory = "/home/soil";
    stateVersion = "20.09";
  };

  imports = [
    ./modules
  ];
}
