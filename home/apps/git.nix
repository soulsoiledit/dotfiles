{
  programs = {
    git = {
      enable = true;

      settings = {
        user.name = "soiledit";
        user.email = "no.sleep410@passinbox.com";
        init.defaultBranch = "main";
      };

      # signing = null;
      lfs.enable = true;
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    lazygit.enable = true;
  };
}
