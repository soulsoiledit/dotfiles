{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # modern unix replacements
    dua
    du-dust
    duf

    # qol
    tmux
    p7zip
    trash-cli
    xdg-utils

    # service interaction
    libnotify
    wl-clipboard
    pamixer
    brightnessctl
    playerctl
    grimblast
  ];

  programs = {
    bat.enable = true;
    fd.enable = true;
    fzf.enable = true;
    jq.enable = true;
    zoxide.enable = true;

    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
    zellij.enable = true;

    fastfetch.enable = true;
    hyfetch.enable = true;

    cava.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      git = true;
      icons = true;
    };
  };
}
