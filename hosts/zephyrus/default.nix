{ inputs, ... }:

{
  imports = [ ./hardware.nix ] ++ inputs.self.lib.autoimport ../../system;

  networking.hostName = "zephyrus";

  opts = {
    compositor.hyprland.enable = true;

    zram.enable = true;
    podman.enable = true;
    virt-manager.enable = true;

    # used for rebinding laptop keys
    kanata.enable = true;
  };

  hardware.graphics.enable32Bit = true;
  powerManagement.cpuFreqGovernor = "powersave";

  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
  };
}
