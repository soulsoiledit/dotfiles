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
  powerManagement.cpuFreqGovernor = "schedutil";

  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  services.power-profiles-daemon.enable = true;

  services.supergfxd = {
    settings = null;
  };

  # services.udev.extraRules = ''
  #   ACTION=="add", ATTRS{idVendor}=="c2ab", ATTRS{idProduct}=="3939", RUN+="${
  #     pkgs.writeShellScriptBin "kb-add" ''
  #       DISPLAY=:0 HOME=/home/soil ${lib.getExe pkgs.xorg.xinput} disable 'AT Translated Set 2 keyboard'
  #     ''
  #   }/bin/kb-add"
  #   ACTION=="remove", ATTRS{idVendor}=="c2ab", ATTRS{idProduct}=="3939", RUN+="${
  #     pkgs.writeShellScriptBin "kb-remove" ''
  #       DISPLAY=:0 HOME=/home/soil ${lib.getExe pkgs.xorg.xinput} enable 'AT Translated Set 2 keyboard'
  #     ''
  #   }/bin/kb-remove"
  # '';
}
