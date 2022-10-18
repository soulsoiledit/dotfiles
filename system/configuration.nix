{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
    ./laptop.nix
  ];

  system.stateVersion = "22.05";

  # Boot {{{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
    };
    blacklistedKernelModules = [ "acpi_cpufreq_init" ];
    kernelModules = [ "amd_pstate" ];
    plymouth.enable = true;
  };
  # }}}
  # Swap {{{
  #swapDevices = [{
  #  device = "/var/swap";
  #  size = 2048;
  #}];
  swapDevices = [{
    device = "/var/swap";
    size = 2048;
  }];
  # }}}
  # Locale {{{
  time.timeZone = "US/Central";
  # }}}
  # Nix {{{
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixUnstable;

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    extraOptions = ''
      keep-outputs = true
      experimental-features = nix-command flakes ca-derivations
    '';
  };
  # }}}
  # Services {{{
  services = {
    openssh.enable = true;
    journald.extraConfig = "SystemMaxUse=100M";
    udisks2.enable = true;
  };
  programs.ssh.startAgent = true;

  programs.dconf.enable = true;

  services.gnome.gnome-keyring.enable = true;
  # }}}
  # Fonts {{{
  fonts = {
    fonts = with pkgs; [ (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; }) ];
  };
  # }}}
  # Networking {{{
  networking = {
    hostName = "soilnix";
    networkmanager.enable = true;
  };
  # }}}
  # User {{{
  users.users.soil = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "video" "networkmanager" ];
  };
  programs.fish.enable = true;
  # }}}
  # Audio {{{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.bluetooth.enable = true;

  # xorg
  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.sx.enable = true;
    excludePackages = [ pkgs.xterm ];

    monitorSection = ''
      DisplaySize 302 189
    '';
  };

  # wayland
  programs.sway.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "soil";
        #command = "${pkgs.greetd.tuigreet}/bin/tuigreet -c '${pkgs.river}/bin/river -c /home/soil/.config/waysession'";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -c ${pkgs.sx}/bin/sx";
      };
    };
  };

  programs.command-not-found.enable = false; # temporary
  services.udev.packages = [ pkgs.qmk-udev-rules ];

  hardware.logitech.wireless.enable = true;
  services.ratbagd.enable = true;

  xdg.portal = {
    enable = true;
    #wlr.enable = true;
  };

  virtualisation.virtualbox.host.enable = true;
}
