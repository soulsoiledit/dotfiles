{ lib, pkgs, ... }:

{
  imports = [ ./hardware.nix ];
  networking.hostName = "zephyrus";

  powerManagement.cpuFreqGovernor = "powersave";

  services = {
    upower = {
      enable = true;
      noPollBatteries = true;
    };

    power-profiles-daemon.enable = true;

    asusd = {
      # enable = true;
      enableUserService = true;
    };
  };
}
