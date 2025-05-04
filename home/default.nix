{
  programs.home-manager.enable = true;

  home = {
    username = "soil";
    homeDirectory = "/home/soil";
    stateVersion = "24.05";
  };

  # TODO: gpg keysigning and ssh
}
