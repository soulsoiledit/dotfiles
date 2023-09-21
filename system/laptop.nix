{ config, pkgs, ... }:

{
  boot = {
    kernelParams = [
      "amd_pstate=active"
    ];
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  programs.rog-control-center = {
    enable = true;
    autoStart = true;
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
