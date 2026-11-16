{ pkgs, ... }:

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

  boot.kernelModules = [ "msr" ];
  systemd.services.disable-c6 = {
    description = "Disable c6";
    wantedBy = [ "multi-user.target" ];
    script = "${pkgs.zenstates}/bin/zenstates --c6-disable";
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "sleep";
    HandleSuspendKey = "sleep";
  };
}
