{
  imports = [ ./hardware.nix ];
  networking.hostName = "zephyrus";

  # disable amd-pstate to hopefully resolve suspend problems
  boot.kernelParams = [ "amd_pstate=passive" ];

  powerManagement = {
    # schedutil is good enough
    cpuFreqGovernor = "schedutil";
  };

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
