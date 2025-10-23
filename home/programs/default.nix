{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pwvucontrol

    steam
    (prismlauncher.override (prev: {
      jdks = [
        prev.jdk8
        prev.jdk17
        prev.jdk21
        jdk25
      ];
    }))
    olympus

    du-dust
    dua
    duf
    trashy

    brightnessctl
    libnotify
    playerctl
    wl-clipboard

    libreoffice-fresh
  ];

  programs = {
    obs-studio = {
      enable = true;
      plugins = [ pkgs.obs-studio-plugins.obs-pipewire-audio-capture ];
    };

    bat.enable = true;
    eza.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    fzf.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
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
  };
}
