{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # modern unix replacements
    du-dust
    dua
    duf
    trashy

    # service control
    brightnessctl
    libnotify
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
    television.enable = true;
    tmux.enable = true;
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

    zellij = {
      enable = true;
      enableFishIntegration = false;
    };
  };
}
