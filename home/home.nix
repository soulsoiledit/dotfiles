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
      $DRY_RUN_CMD rm -rf ~/.config/nvim/init.vim
	'';
  };

  imports = [ ./modules ];
}
