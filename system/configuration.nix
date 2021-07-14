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
  programs.command-not-found.enable = false; # temporary

  # qmk {{{
  services.udev.extraRules = ''
    # Atmel DFU
    ### ATmega16U2
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2fef", TAG+="uaccess"
    ### ATmega32U2
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff0", TAG+="uaccess"
    ### ATmega16U4
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff3", TAG+="uaccess"
    ### ATmega32U4
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff4", TAG+="uaccess"
    ### AT90USB64
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff9", TAG+="uaccess"
    ### AT90USB162
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ffa", TAG+="uaccess"
    ### AT90USB128
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ffb", TAG+="uaccess"

    # Input Club
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1c11", ATTRS{idProduct}=="b007", TAG+="uaccess"

    # STM32duino
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1eaf", ATTRS{idProduct}=="0003", TAG+="uaccess"
    # STM32 DFU
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", TAG+="uaccess"

    # BootloadHID
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05df", TAG+="uaccess"

    # USBAspLoader
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05dc", TAG+="uaccess"

    # ModemManager should ignore the following devices
    # Atmel SAM-BA (Massdrop)
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="6124", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"

    # Caterina (Pro Micro)
    ## Spark Fun Electronics
    ### Pro Micro 3V3/8MHz
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b4f", ATTRS{idProduct}=="9203", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ### Pro Micro 5V/16MHz
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b4f", ATTRS{idProduct}=="9205", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ### LilyPad 3V3/8MHz (and some Pro Micro clones)
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b4f", ATTRS{idProduct}=="9207", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ## Pololu Electronics
    ### A-Star 32U4
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1ffb", ATTRS{idProduct}=="0101", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ## Arduino SA
    ### Leonardo
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0036", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ### Micro
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0037", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ## Adafruit Industries LLC
    ### Feather 32U4
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", ATTRS{idProduct}=="000c", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ### ItsyBitsy 32U4 3V3/8MHz
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", ATTRS{idProduct}=="000d", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ### ItsyBitsy 32U4 5V/16MHz
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", ATTRS{idProduct}=="000e", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ## dog hunter AG
    ### Leonardo
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2a03", ATTRS{idProduct}=="0036", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
    ### Micro
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2a03", ATTRS{idProduct}=="0037", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"

    # hid_listen
    KERNEL=="hidraw*", MODE="0660", GROUP="plugdev", TAG+="uaccess", TAG+="udev-acl"
  '';
  # }}}
}
