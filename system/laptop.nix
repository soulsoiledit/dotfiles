{ config, pkgs, ... }:

{
  # Laptop Power Management
  boot = {
    kernelParams = [
      "amd_pstate=active"
    ];

    blacklistedKernelModules = [ "acpi_cpufreq_init" ];
    kernelModules = [ "amd_pstate" ];
  };

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";

  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  services.power-profiles-daemon.enable = true;

  services.supergfxd = {
    settings = null;
  };
}
