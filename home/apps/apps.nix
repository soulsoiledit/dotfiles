{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pwvucontrol

    steam
    prismlauncher
    olympus

    dua
    duf
    jaq
    ouch
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
      stdlib = # bash
        ''
          direnv_layout_dir() {
            pwd_hash="$(basename "$PWD")-$(echo -n "$PWD" | sha256sum | cut -d " " -f 1)"
            echo "${config.xdg.cacheHome}/direnv/layouts/$pwd_hash"
          }
        '';
    };
  };

  services = {
    playerctld.enable = true;
    network-manager-applet.enable = true;
    udiskie.enable = true;
  };
}
