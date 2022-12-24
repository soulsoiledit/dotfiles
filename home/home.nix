{ config, pkgs, ... }:

# TODO
# center block?
#   window name?
#   song name

# work on spotify w/ playerctl module
# work on power menu
# work on quick app menu

# keyboard brightness notification
# find good breathing rainbow led mode
# fix aura conf
# add refresh rate swapping
# add cpu profile swapping
# add other asusctl config file options and PR

# window border?
# window transparency?
# window blur?

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  home = {
    username = "soil";
    homeDirectory = "/home/soil";
    stateVersion = "22.05";
  };

  imports = [ ./modules ];
}
