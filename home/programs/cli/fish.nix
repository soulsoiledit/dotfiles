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

      ns = "nh os switch --ask";
      nb = "nh os boot --ask";
      nup = "nix flake update --flake $FLAKE";
      hs = "nh home switch --ask";
    };
  };

  # prompt
  programs.starship.enable = true;
}
