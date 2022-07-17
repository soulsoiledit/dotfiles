{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ./laptop.nix ];

  system.stateVersion = "22.05";

  # Boot {{{
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelPatches = [ { name = "MT7922 Patch"; patch = ./mt7922.patch; } ];
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
    };
    plymouth.enable = true;
  };
  # }}}
  # Swap {{{
  #swapDevices = [{
  #  device = "/var/swap";
  #  size = 2048;
  #}];
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
  };

  programs.dconf.enable = true;
  # }}}
  # Fonts {{{
  fonts = {
    fonts = with pkgs; [ (nerdfonts.override { fonts = [ "UbuntuMono" ]; }) ];
  };
  # }}}
  # Networking {{{
  networking = {
    hostName = "soilnix";
    wireless.userControlled.enable = true;
  };
  services.connman.enable = true;
  # }}}
  # User {{{
  users.users.soil = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "video" ];
  };
  programs.fish.enable = true;
  # }}}
  # Audio {{{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  hardware.bluetooth.enable = true;

  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.sx.enable = true;
    dpi = 216;
  };

  services.greetd = {
    enable = false;
    settings = {
      default_session = {
        user = "soil";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -c ${(pkgs.writeShellScriptBin "river-session" ''
            export WLR_NO_HARDWARE_CURSOR = 1
            ${pkgs.river}/bin/river
          '')}/bin/river-session
	    ";
      };
    };
  };

  programs.command-not-found.enable = false; # temporary
  services.udev.packages = [ pkgs.qmk-udev-rules ];
}
