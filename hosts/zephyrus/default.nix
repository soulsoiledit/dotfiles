{
  inputs,
  lib,
  pkgs,
  ...
}:

let
  ryzenadj = "${lib.getExe pkgs.ryzenadj} --set-coall=0x100020";
in
{
  imports = [
    ./hardware.nix
  ] ++ inputs.self.lib.autoimport ../../system;

  networking.hostName = "zephyrus";

  modules = {
    compositor.niri.enable = true;

    zswap = {
      enable = true;
      maxPoolPercent = 50;
    };

    swap = {
      enable = true;
      size = 20;
    };

    # used for rebinding laptop keys
    kanata.enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics.enable32Bit = true;

  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
    supergfxd.enable = true;
  };

  # combination of
  # https://github.com/sammilucia/set-coall-timer
  # and builtin powerManagement commands
  powerManagement = {
    powerUpCommands = ryzenadj;
    powerDownCommands = ryzenadj;
  };

  systemd = {
    services.set-coall = {
      description = "Override AMD Curve Optimizer";
      script = ryzenadj;
    };

    timers.set-coall = {
      description = "Override AMD Curve Optimizer on startup and every 5 minutes thereafter";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "30sec";
        OnUnitActiveSec = "5min";
      };
    };
  };
}
