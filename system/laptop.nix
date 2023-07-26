{ config, pkgs, ... }:

{
  boot = {
    kernelParams = [
      "amd_pstate=active"
    ];
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  services = {
    power-profiles-daemon.enable = true;

    asusd = {
      enable = true;
      enableUserService = true;
    };

    supergfxd = {
      enable = true;
    };
  };
}
