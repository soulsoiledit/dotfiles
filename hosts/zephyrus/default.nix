{ pkgs, ... }:

{
  imports = [ ./hardware.nix ];
  networking.hostName = "zephyrus";

  boot = {
    kernelParams = [ "amd_pstate=active" ];
  };

  powerManagement = {
    cpuFreqGovernor = "powersave";
  };

  # powerprofilesctl
  # openrgb

  services = {
    upower.enable = true;

    asusd = {
      enable = true;
      # user services seems to be unfinished atm...
      # enableUserService = true;
    };
  };

  programs.rog-control-center.enable = true;

  # colemakdh/kanata configuration ...
}
