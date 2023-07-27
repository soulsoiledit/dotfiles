{ config, pkgs, inputs, lib, ... }:

{
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

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      experimental-features = [ "nix-command" "flakes" "ca-derivations" ];

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
      source-han-sans
      (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    ];
  };

  networking = {
    hostName = "soilnix";
    networkmanager.enable = true;
  };

  users.users.soil = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "video" "networkmanager" ];
  };

  programs.fish.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.sx.enable = true;

    excludePackages = [ pkgs.xterm ];
  };

  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} -t -c ${lib.getExe pkgs.sx}";
      };
    };
  };

  virtualisation.podman.enable = true;

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
