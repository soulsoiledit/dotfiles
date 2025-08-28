{
  programs.git = {
    enable = true;
    delta.enable = true;

    userName = "soiledit";
    userEmail = "no.sleep410@passinbox.com";

    # signing = null;

    extraConfig.init.defaultBranch = "main";
  };

  programs.lazygit.enable = true;
}
