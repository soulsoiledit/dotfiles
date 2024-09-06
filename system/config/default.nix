{
  system.stateVersion = "24.05";

  time.timeZone = "US/Central";

  programs = {
    git.enable = true;
    neovim.enable = true;
  };

  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';
}
