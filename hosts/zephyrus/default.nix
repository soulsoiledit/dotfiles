{ inputs, ... }:

{
  imports = [ ./hardware.nix ] ++ inputs.self.lib.autoimport ../../system;

  networking.hostName = "zephyrus";

  powerManagement.cpuFreqGovernor = "powersave";

  services = {
    upower = {
      enable = true;
      noPollBatteries = true;
    };

    power-profiles-daemon.enable = true;
  };
}
