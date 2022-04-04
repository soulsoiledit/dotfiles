{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "22.05";

  # Boot {{{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
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

    wireless = {
      enable = true;
      interfaces = [ "wlp5s0" ];
      userControlled.enable = true;
    };
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
  # Input {{{
  services.xserver.libinput.enable = true;
  # }}}
  # Audio {{{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  hardware.bluetooth.enable = true;

  # }}}
  # X11 {{{
  services.xserver = {
    enable = true;
    windowManager.awesome.enable = true;
    displayManager = {
      defaultSession = "none+awesome";
      lightdm = {
        enable = true;
        extraConfig = "user-authority-in-system-dir=true";
        background = "/";
        greeters.mini = {
          enable = true;
          user = "soil";
          extraConfig = let theme = (import ../other/colors.nix).theme;
          in ''
            [greeter]
            show-password-label = false
            password-alignment = left
            show-input-cursor = true
            [greeter-hotkeys]
            shutdown-key = p
            suspend-key = s
            [greeter-theme]
            font = "UbuntuMono Nerd Font"
            font-size = 1em
            font-weight = normal
            border-width = 0px
            password-border-width = 0px
            background-color = "${theme.background}"
            window-color = "${theme.background}"
            password-background-color = "${theme.selection}"
            password-color = "${theme.foreground}"
            error-color = "${theme.foreground}"
          '';
        };
      };
    };
  };
  # }}}

  programs.command-not-found.enable = false; # temporary
  services.udev.packages = [ pkgs.qmk-udev-rules ];
}
