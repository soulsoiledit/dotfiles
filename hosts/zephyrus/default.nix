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
      size = 4 * 1024;
    }
  ];

  hardware.graphics.enable32Bit = true;

  programs.niri.enable = true;
  security.pam.services.gtklock = { };

  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;

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
      description = "Override AMD Curve Optimizer";
      script = "${lib.getExe pkgs.ryzenadj} --set-coall=0x100020";
    };

    timers.set-coall = {
      description = "Override AMD Curve Optimizer on startup and every 10 minutes thereafter";
      timerConfig = {
        OnBootSec = "1min";
        OnUnitActiveSec = "10min";
        Persistent = true;
      };
      wantedBy = [ "timers.target" ];
    };
  };
}
