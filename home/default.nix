{
  programs.home-manager.enable = true;

  home = {
    username = "soil";
    homeDirectory = "/home/soil";
    stateVersion = "25.11";
  };

  # TODO: gpg keysigning and ssh
}
