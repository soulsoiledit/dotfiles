{
  programs.git = {
    enable = true;
    delta.enable = true;

    userName = "soulsoiledit";
    userEmail = "no.sleep410@passinbox.com";

    # TODO: setup and use gpg signing
    # signing = null;

    extraConfig.init.defaultBranch = "main";
  };

  programs.lazygit.enable = true;
}
