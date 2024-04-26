{
  programs.git = {
    enable = true;
    userName = "soulsoiledit";
    userEmail = "soulsoill@proton.me";

    delta = {
      enable = true;
      catppuccin.enable = true;
    };

    signing = null;

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      config.pull.rebase = true;
    };
  };

  programs.lazygit = {
    enable = true;
    catppuccin.enable = true;
  };
}
