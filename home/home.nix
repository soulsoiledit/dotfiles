{ config, pkgs, ... }:

# TODO
# minimize bar info
# center block?
#   window name?
#   song name

# window border?
# window transparency?

# xmonad?
# awesome?
# stumpwm?

# emacs

{
  programs.home-manager.enable = true;

  home = {
    stateVersion = "20.09";

    activation.removeClutter = ''
      $DRY_RUN_CMD rm -rf ~/.config/nvim/init.vim ~/.icons/ ~/.config/emacs/
      $DRY_RUN_CMD mv ~/.emacs.d/ ~/.config/emacs/ 
    '';
  };

  imports = [
    ./modules
  ];
}
