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

  boot.kernelParams = [
    "zswap.max_pool_percent=50"
    "pcie_aspm.policy=powersupersave"
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

  # set charge limit
  services.udev.extraRules = ''
    ACTION=="add", KERNEL=="asus-nb-wmi", RUN+="${pkgs.runtimeShell} -c 'echo 60 > /sys/class/power_supply/BAT?/charge_control_end_threshold'"
  '';

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
