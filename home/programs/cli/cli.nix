{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # modern unix replacements
    du-dust
    dua
    duf
    trashy

    tmux

    # service control
    brightnessctl
    libnotify
    pamixer
    playerctl
    wl-clipboard
  ];

  programs = {
    bat.enable = true;
    cava.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    fzf.enable = true;
    jq.enable = true;
    zellij.enable = true;
    zoxide.enable = true;

    btop = {
      enable = true;
      settings = {
        proc_tree = true;
        proc_gradient = false;
        proc_filter_kernel = true;
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      git = true;
      icons = "always";
    };

    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
  };
}
