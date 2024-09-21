{
  programs.git = {
    enable = true;
    userName = "soulsoiledit";
    userEmail = "no.sleep410@passinbox.com";

    delta.enable = true;

    # TODO: add keys
    signing = null;

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      config.pull.rebase = true;
    };
  };

  programs.lazygit = {
    enable = true;
  };
}
