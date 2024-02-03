{
  # disable amd-pstate to hopefully resolve suspend problems
  boot.kernelParams = [ "initcall_blacklist=amd_pstate_init" ];

  powerManagement = {
    # ondemand is good enough
    cpuFreqGovernor = "ondemand";
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
