{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pwvucontrol

    steam
    prismlauncher
    olympus

    dua
    duf
    trashy

    brightnessctl
    libnotify
    playerctl
    wl-clipboard

    libreoffice-fresh
    kdePackages.kdenlive
    losslesscut-bin
  ];

  programs = {
    obs-studio = {
      enable = true;
      plugins = [ pkgs.obs-studio-plugins.obs-pipewire-audio-capture ];
    };

    bat.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
    television.enable = true;
    zoxide.enable = true;
    zellij.enable = true;

    btop = {
      enable = true;
      settings = {
        proc_tree = true;
        proc_gradient = false;
        proc_filter_kernel = true;
      };
    };

    eza = {
      enable = true;
      icons = "auto";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
