{ config, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = # fish
      ''
        set fish_greeting
      '';

    shellAbbrs = {
      s = "sudo";
      e = config.home.sessionVariables.EDITOR;
      f = config.programs.yazi.shellWrapperName;
      g = "lazygit";
      a = "7z";

      ns = "nh os switch";
      nb = "nh os boot";
      hs = "nh home switch";
    };
  };

  # prompt
  programs.starship.enable = true;
}
