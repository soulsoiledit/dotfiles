{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./laptop.nix
  ];

  system.stateVersion = "22.05";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
    };
    plymouth.enable = true;
  };

  time.timeZone = "US/Central";

  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixUnstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      experimental-features = ["nix-command" "flakes" "ca-derivations"];

      warn-dirty = false;
      keep-outputs = true;
      auto-optimise-store = true;
    };
  };

  services = {
    openssh.enable = true;
    journald.extraConfig = "SystemMaxUse=100M";
    udisks2.enable = true;
  };
  programs.dconf.enable = true;

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts-cjk
      noto-fonts-extra
      (nerdfonts.override {fonts = ["FantasqueSansMono"];})
    ];
  };

  networking = {
    hostName = "soilnix";
    networkmanager.enable = true;
    # networkmanager.wifi.backend = "iwd";
  };

  users.users.soil = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "networkmanager"
      # "docker"
    ];
  };

  programs.fish.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  programs.hyprland.enable = true;
  security.pam.services.swaylock = {};

  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} -t -c Hyprland";
      };
    };
  };

  # virtualisation.docker.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  programs.command-not-found.enable = false; # temporary
  hardware.logitech.wireless.enable = true;
  services.ratbagd.enable = true;

  hardware.opengl.driSupport32Bit = true;
}
