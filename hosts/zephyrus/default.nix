{ inputs, ... }:

{
  imports = [ ./hardware.nix ] ++ inputs.self.lib.autoimport ../../system;

  opts = {
    compositor.hyprland.enable = true;

    gaming.enable = true;
    podman.enable = true;
    virt-manager.enable = true;

    # used for rebinding laptop keys
    kanata.enable = true;
  };

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
