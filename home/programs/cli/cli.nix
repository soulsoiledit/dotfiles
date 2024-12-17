{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # modern unix replacements
    dua
    du-dust
    duf
    trashy

    tmux
    file

    # service control
    libnotify
    wl-clipboard
    pamixer
    brightnessctl
    playerctl
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
      icons = "always";
    };
  };
}
