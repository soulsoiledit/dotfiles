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
	username = "soil";
	homeDirectory = "/home/soil";
	stateVersion = "22.05";

    activation.removeClutter = ''
      $DRY_RUN_CMD rm -rf ~/.config/nvim/init.vim ~/.icons/
    '';
  };

  programs.foot = {
    #enable = true;
    #server.enable = true;

    settings = {
      main.font = "UbuntuMono Nerd Font:size=8";
      mouse.hide-when-typing = "no";
    };
  };

  imports = [ ./modules ];
}
