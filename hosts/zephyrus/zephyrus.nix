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

  boot.kernelParams = [ "amd_pstate=guided" ];
  hardware.amdgpu.initrd.enable = true;
  hardware.graphics.enable32Bit = true;

  programs.niri.enable = true;
  programs.niri.useNautilus = false;

  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
    asusd.enable = true;

    # value found by experimenting
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl2", ATTR{max_brightness}="64532"
    '';

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
