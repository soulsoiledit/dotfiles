# Define asusctl config in Nix
# - Find good breathing rainbow led mode
# - Keyboard brightness notification
{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  home = {
    username = "soil";
    homeDirectory = "/home/soil";
    stateVersion = "23.11";
  };

  imports = [./modules];
}
