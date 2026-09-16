{ lib, pkgs, ... }:

{
  imports = [ ./hardware.nix ];

  system.stateVersion = "25.11";

  networking.hostName = "zephyrus";
  time.timeZone = "US/Central";

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
  };

  swapDevices = [
    {
      device = "/var/swapfile";
      size = 6 * 1024;
    }
  ];

  nixpkgs.overlays = [
    (final: prev: {
      linux-firmware =
        prev.lib.warnIf (prev.lib.compareVersions prev.linux-firmware.version "20260910" == 1)
          "a newer linux-firmware is now in nixos-unstable, check whether we can remove the override"
          prev.linux-firmware.overrideAttrs
          (old: {
            version = "main";
            src = prev.fetchFromGitLab {
              owner = "kernel-firmware";
              repo = "linux-firmware";
              rev = "f15c84dc2d8fb73b3bc459efeece58dcdc27e53a";
              hash = "sha256-XAEgGj4o+ROt4Eg7QQgfrZ+hT8yPj3fG+WJbAfEFlxw=";
            };
          });
    })
  ];

  boot.kernelParams = [ "amd_pstate=guided" ];
  hardware.amdgpu.initrd.enable = true;
  hardware.graphics.enable32Bit = true;

  programs.niri.enable = true;
  programs.niri.useNautilus = false;

  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
    asusd.enable = true;

    kanata = {
      enable = true;
      keyboards.default.devices = [
        "/dev/input/by-id/usb-ASUSTeK_Computer_Inc._N-KEY_Device-if02-event-kbd"
      ];
    };
  };

  # https://github.com/sammilucia/set-coall-timer
  # prevent apu freezes
  systemd = {
    services.set-coall = {
      description = "Overvolt 80-120mV";
      script = "${lib.getExe pkgs.ryzenadj} --set-coall=0x100020";
    };

    timers.set-coall = {
      description = "Overvolt 80-120mV periodically";
      timerConfig = {
        OnActiveSec = "0s";
        OnUnitActiveSec = "10m";
        Persistent = true;
      };
      wantedBy = [ "timers.target" ];
    };
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "sleep";
    HandleSuspendKey = "sleep";
  };
}
