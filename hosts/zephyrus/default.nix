{
  inputs,
  lib,
  pkgs,
  ...
}:

let
  modprobe = lib.getExe' pkgs.kmod "modprobe";
  brightnessctl = lib.getExe pkgs.brightnessctl;
in
{
  imports = [
    ./hardware.nix
  ] ++ inputs.self.lib.autoimport ../../system;

  system.stateVersion = "24.05";

  networking.hostName = "zephyrus";
  time.timeZone = "US/Central";

  swapDevices = [
    {
      device = "/var/swapfile";
      size = 20 * 1024;
    }
  ];

  hardware.graphics.enable32Bit = true;

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

  virtualisation.libvirtd.enable = true;

  powerManagement = {
    powerUpCommands = # bash
      ''
        ${modprobe} hid_asus
        ${brightnessctl} --device asus::kbd_backlight --save
        ${brightnessctl} --device asus::kbd_backlight --restore
      '';
    powerDownCommands = # bash
      ''
        ${modprobe} --remove hid_asus
      '';
  };

  # https://github.com/sammilucia/set-coall-timer
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
