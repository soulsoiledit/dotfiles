{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
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
    (config.services.network-manager-applet.package)

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
    numbat.enable = true;
    television.enable = true;
    zellij.enable = true;
    zoxide.enable = true;

    btop = {
      enable = true;
      package = pkgs.btop.override {
        cudaSupport = true;
        rocmSupport = true;
      };
      settings = {
        proc_tree = true;
        proc_gradient = false;
        proc_filter_kernel = true;
      };
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

    eza = {
      enable = true;
      icons = "auto";
    };

    less = {
      enable = true;
      options = {
        ignore-case = true;
        RAW-CONTROL-CHARS = true;
        quit-if-one-screen = true;
        quit-on-intr = true;

        LONG-PROMPT = true;
        window = 4;
        tabs = 4;
      };
    };

    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
  };

  services = {
    playerctld.enable = true;
    network-manager-applet.enable = true;
    udiskie.enable = true;
  };
}
