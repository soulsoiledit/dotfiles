{ config, pkgs, ... }:

{

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = [
    "/home/soil/.local/bin"
    "/home/soil/.local/share/npm/bin"
    "/home/soil/.local/share/cargo/bin"
  ];

  home.packages = with pkgs; [
    tmux

    gdu
    fd
    duf

    acpi
    brightnessctl
    playerctl

    zip
    unzip
    p7zip

    nix-tree

    trash-cli
    xdg-utils

    steam-run
  ];

  programs.fzf.enable = true;
  programs.ripgrep.enable = true;
  programs.nix-index.enable = true;
  programs.hyfetch.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.btop.enable = true;

  xdg.enable = true;

  programs.bat.enable = true;
  programs.eza.enable = true;

  programs.fish = {
    enable = true;

    shellAbbrs = {
      v = "nvim";
      s = "sudo";
      f = "ya";

      ns = "sudo nixos-rebuild switch --flake ~/code/dotfiles";
      hs = "home-manager switch --flake ~/code/dotfiles";
    };

    functions = { };
    plugins = [ ];
  };

  programs.starship.enable = true;
}
