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

  time.timeZone = "US/Central";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot = {
        enable = true;
        editor = false;

        netbootxyz.enable = true;
      };
    };

    plymouth.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixUnstable;
    channel.enable = false;
    registry.nixpkgs.flake = inputs.nixpkgs;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +5";
    };

    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      auto-optimise-store = true;
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };

  services = {
    openssh.enable = true;
    udisks2.enable = true;
  };

  networking = {
    hostName = "soilnix";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
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
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      (nerdfonts.override {fonts = ["FantasqueSansMono"];})
      noto-fonts-cjk
    ];
  };

  console.colors = [
    "1e1e2e"
    "f38ba8"
    "a6e3a1"
    "f9e2af"
    "89b4fa"
    "f5c2e7"
    "94e2d5"
    "bac2de"
    "585b70"
    "f38ba8"
    "a6e3a1"
    "f9e2af"
    "89b4fa"
    "f5c2e7"
    "94e2d5"
    "a6adc8"
  ];

  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} -t -r --remember-user-session";
      };
    };
  };

  programs.hyprland.enable = true;
  security.pam.services.swaylock = {};

  programs.command-not-found.enable = false; # temporary
  services.ratbagd.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # virtualisation.docker.enable = true;
}
