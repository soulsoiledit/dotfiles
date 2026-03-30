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
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    lazygit.enable = true;
  };
}
