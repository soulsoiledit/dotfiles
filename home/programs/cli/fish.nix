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

      ns = "nh os switch --ask";
      nb = "nh os boot --ask";
      nup = "nix flake update --flake ${config.flake}";
      hs = "nh home switch --ask";
    };
  };

  programs.starship.enable = true;
}
