{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware.nix
  ] ++ inputs.self.lib.autoimport ../../system;

  networking.hostName = "zephyrus";

  modules = {
    compositor.niri.enable = true;

    zram.enable = true;
    podman.enable = true;
    virt-manager.enable = true;

    # used for rebinding laptop keys
    kanata.enable = true;
  };

  hardware.graphics.enable32Bit = true;

  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
    supergfxd.enable = true;
  };
}
