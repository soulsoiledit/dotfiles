{ config, pkgs, inputs, ... }:

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
    blacklistedKernelModules = [ "acpi_cpufreq_init" ];
    kernelModules = [ "amd_pstate" ];
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
    kanata = {
        enable = true;
        keyboards = {
          main = {
            devices = [
              "/dev/input/by-id/usb-ASUSTeK_Computer_Inc._N-KEY_Device-if02-event-kbd"
            ];
            config = ''
                (defalias
                  grl (tap-hold 200 200 grv (layer-toggle layers))

                  ;; layer-switch changes the base layer.
                  gal (layer-switch gallium)
                  qwr (layer-switch qwerty)

                  ;; tap for capslk, hold for lctl
                  esc (tap-hold 200 200 esc lctl)
                )

                (defsrc
                  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
                  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                  caps a    s    d    f    g    h    j    k    l    ;    '    ret
                  lsft z    x    c    v    b    n    m    ,    .    /    rsft
                  lctl lmet lalt           spc            ralt rmet rctl)

                (deflayer qwerty
                  @grl  1    2    3    4    5    6    7    8    9    0    -    =    bspc
                  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                  @esc a    s    d    f    g    h    j    k    l    ;    '    ret
                  lsft z    x    c    v    b    n    m    ,    .    /    rsft
                  lctl lmet lalt           spc            ralt rmet rctl
                )

                (deflayer gallium
                  @grl  1    2    3    4    5    6    7    8    9    0    -    =    bspc
                  tab  b    l    d    c    v    z    y    o    u    ,    [    ]    \
                  @esc n    r    t    s    g    p    h    a    e    i    /    ret
                  lsft x    m    w    j    q    k    f    '    ;    .    rsft
                  lctl lmet lalt           spc            ralt rmet rctl
                )

                (deflayer layers
                  _    @qwr @gal lrld _    _    _    _    _    _    _    _    _    _
                  _    _    _    _    _    _    _    _    _    _    _    _    _    _
                  _    _    _    _    _    _    _    _    _    _    _    _    _
                  _    _    _    _    _    _    _    _    _    _    _    _
                  _    _    _              _              _    _    _
                )
              '';
            };
          };
        };
  };
  programs.dconf.enable = true;

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
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
    extraGroups = [ "wheel" "video" "networkmanager" "input" "uinput" ];
  };

  programs.fish.enable = true;

  security.rtkit.enable = true;
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

    excludePackages = [ pkgs.xterm ];

    monitorSection = ''
      DisplaySize 302 189
    '';
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

  programs.command-not-found.enable = false; # temporary
  services.udev.packages = [ pkgs.qmk-udev-rules ];

  hardware.logitech.wireless.enable = true;
  services.ratbagd.enable = true;

  # Swap and zram
  # swapDevices = [{
  #   device = "/var/swap";
  #   size = 2048;
  # }];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
    # writebackDevice =
  };

  virtualisation.podman.enable = true;
}
