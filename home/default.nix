{
  programs.home-manager.enable = true;

  home = {
    username = "soil";
    homeDirectory = "/home/soil";
    stateVersion = "24.05";
  };

  terminal = "footclient";

  modules = {
    niri.enable = true;

    foot.enable = true;
    wezterm.enable = true;
  };
}
