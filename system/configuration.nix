{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./cachix.nix
  ];

  system = {
    stateVersion = "20.03";
  };
  # Boot {{{
  boot = {
    tmpOnTmpfs = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    plymouth.enable = true;
    blacklistedKernelModules = [ "pcspkr" ];
  };
  # }}}
  # Swap {{{
  swapDevices = [{
    device = "/var/swap";
    size = 8192;
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
    # extraGroups = ["wheel" "video" "libvirtd"];
    extraGroups = ["wheel" "video"];
  };
  # programs.zsh.enable = true;
  programs.fish.enable = true;
  # }}}
  # Input {{{
  services.xserver.xkbOptions = "compose:ralt";

  services.xserver.libinput = {
    enable = true;
    # scrollMethod = "edge";
  };
  # }}}
  # Audio {{{
  sound.enable = true;
  hardware = {
    pulseaudio = {
      enable = true;
      extraConfig = ''
        load-module module-switch-on-connect
      '';
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
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
          extraConfig = ''
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
            background-color = "#2a2426"
            window-color = "#2a2426"
            password-background-color = "#444444"
            password-color = "#e6d6ac"
            error-color = "#e6d6ac"
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
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __VK_LAYER_NV_optimus=NVIDIA_only
        exec -a "$0" "$@"
      '')
    ];
  # }}}
  # Laptop Power Management {{{
    powerManagement = {
      enable = true;
      powertop.enable = true;
    };

    services.tlp.enable = true;
  # }}}
  # # Virtualisation {{{
  # virtualisation.libvirtd = {
  #   enable = true;
  #   qemuPackage = pkgs.qemu_kvm;
  # };
  # # }}}
}
