{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "20.03";

  # Boot {{{

  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 2;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    plymouth.enable = true;
  };
  # }}}
  # Swap {{{
  swapDevices = [{
    device = "/var/swap";
    size = 2048;
  }];
  # }}}
  # Locale {{{
  time.timeZone = "America/Chicago";
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
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
  };
  # }}}
  # Services {{{
  services = {
    openssh.enable = true;
    dbus.packages = with pkgs; [ gnome3.dconf ];
    journald.extraConfig = "SystemMaxUse=100M";
  };
  systemd.packages = [ pkgs.dconf ];
  # }}}
  # Fonts {{{
  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "UbuntuMono" ]; })
    ];
  };
  # }}}
  # Networking {{{
  networking = {
    hostName = "soilnix";

    wireless = {
      enable = true;
      interfaces = [ "wlp4s0" ];
      userControlled.enable = true;
    };
  };

  services.connman = {
    enable = true;
    enableVPN = false;
  };
  # }}}
  # User {{{
  users.users.soil = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ["wheel" "video" ];
  };
  programs.fish.enable = true;
  # }}}
  # Input {{{
  services.xserver.libinput.enable = true;
  # }}}
  # Audio {{{
  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraConfig = ''
        load-module module-switch-on-connect
      '';
    };

    bluetooth.enable = true;
  };
  # }}}
  # X11 {{{
  services.xserver = {
    enable = true;
    windowManager.spectrwm.enable = true;
    displayManager = {
      defaultSession = "none+spectrwm";
      lightdm = {
        enable = true;
        # extraConfig = "user-authority-in-system-dir=true";
        background = "/";
        greeters.mini = {
          enable = true;
          user = "soil";
          extraConfig =
            let
              theme = (import ../other/colors.nix).theme;
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
  # Nvidia {{{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "nvidia-offload" ''
      __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only $@
    '')
  ];

  nixpkgs.overlays = [
    (self: super: {
      spectrwm = super.spectrwm.overrideAttrs (_: {
        pname = "spectrwm";
        version = "3.4.2";
        src = pkgs.fetchFromGitHub {
          owner = "conformal";
          repo = "spectrwm";
          rev = "92589afb194a931b7bcaff6e6258a74a2e6265aa";
          sha256 = "JaemmrUiFyj8/6mZDyKefpH/+iRDyYJJdpCuqy4tsBI=";
        };
      });
    })
  ];
  # }}}
  # Laptop Power Management {{{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services.tlp.enable = true;
  # }}}
  # Virtualisation {{{
  virtualisation.libvirtd.enable = true;
  # }}}
  programs.command-not-found.enable = false; # temporary
}
