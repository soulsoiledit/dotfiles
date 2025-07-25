{ pkgs, ... }:

{
  home.packages = with pkgs; [
    du-dust
    dua
    duf
    trashy

    brightnessctl
    libnotify
    playerctl
    wl-clipboard
  ];

  programs = {
    bat.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    fzf.enable = true;
    jq.enable = true;
    zoxide.enable = true;
    zellij.enable = true;

    television.enable = true;
    television.enableFishIntegration = false;

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
