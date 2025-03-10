{
  inputs,
  lib,
  pkgs,
  ...
}:

let
  modprobe = lib.getExe' pkgs.kmod "modprobe";
  brightnessctl = lib.getExe pkgs.brightnessctl;
in
{
  imports = [
    ./hardware.nix
  ] ++ inputs.self.lib.autoimport ../../system;

  networking.hostName = "zephyrus";

  modules = {
    zswap = {
      enable = true;
      maxPoolPercent = 50;
    };

    swap = {
      enable = true;
      size = 20;
    };

    podman.enable = true;
    libvirt.enable = true;

    # used for rebinding laptop keys
    kanata.enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics.enable32Bit = true;

  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
  };

  powerManagement = {
    powerUpCommands = ''
      ${modprobe} -r hid_asus && ${modprobe} hid_asus
      ${brightnessctl} -d *kbd* -r
    '';
    powerDownCommands = ''
      ${brightnessctl} -d *kbd* -s
    '';
  };

  # https://github.com/sammilucia/set-coall-timer
  systemd = {
    services.set-coall = {
      description = "Override AMD Curve Optimizer";
      script = "${lib.getExe pkgs.ryzenadj} --set-coall=0x100020";
    };

    timers.set-coall = {
      description = "Override AMD Curve Optimizer on startup and every 10 minutes thereafter";
      timerConfig = {
        OnBootSec = "1min";
        OnUnitActiveSec = "10min";
        Persistent = true;
      };
      wantedBy = [ "timers.target" ];
    };
  };
}
