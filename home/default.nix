{
  programs.home-manager.enable = true;

  home = {
    username = "soil";
    homeDirectory = "/home/soil";
    stateVersion = "24.05";
    preferXdgDirectories = true;
  };

  xdg.enable = true;

  modules.niri.enable = true;
}
