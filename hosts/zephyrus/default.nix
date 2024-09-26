{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware.nix
  ] ++ inputs.self.lib.autoimport ../../system;

  networking.hostName = "zephyrus";

  modules = {
    compositor.niri.enable = true;

    zram.enable = true;
    podman.enable = true;
    virt-manager.enable = true;

    # used for rebinding laptop keys
    kanata.enable = true;
  };

  hardware.cpu.x86.msr.enable = true;
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    resumeDevice = "/dev/disk/by-label/nixos";
    kernelParams = [ "resume_offset=7262208" ];
  };

  powerManagement.powerUpCommands = ''
    ${lib.getExe pkgs.zenstates} --c6-disable
  '';

  # setting up hibernate
  swapDevices = [
    {
      device = "/var/swapfile";
      size = 1024 * 18;
    }
  ];

  hardware.graphics.enable32Bit = true;

  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
    supergfxd.enable = true;
  };
}
