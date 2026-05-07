{ lib, pkgs, ... }:

{
  imports = [ ./hardware.nix ];

  system.stateVersion = "25.11";

  networking.hostName = "zephyrus";
  time.timeZone = "US/Central";

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
  };

  swapDevices = [
    {
      device = "/var/swapfile";
      size = 20 * 1024;
    }
  ];

  hardware.graphics.enable32Bit = true;

  programs.niri.enable = true;
  programs.niri.useNautilus = false;
  security.pam.services.gtklock = { };

  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;

    kanata = {
      enable = true;
      keyboards.default.devices = [
        "/dev/input/by-id/usb-ASUSTeK_Computer_Inc._N-KEY_Device-if02-event-kbd"
      ];
    };
  };

  # https://github.com/sammilucia/set-coall-timer
  # prevent apu freezes
  systemd = {
    services.set-coall = {
      description = "Overvolt 80-120mV";
      script = "${lib.getExe pkgs.ryzenadj} --set-coall=0x100020";
    };

    timers.set-coall = {
      description = "Overvolt 80-120mV periodically";
      timerConfig = {
        OnActiveSec = "0s";
        OnUnitActiveSec = "10m";
        Persistent = true;
      };
      wantedBy = [ "timers.target" ];
    };
  };

  virtualisation = {
    libvirtd.enable = true;
  };

  users.users.default.extraGroups = [ "vboxusers" ];

  systemd.services.keyboard-rgb-hibernate = {
    description = "unload keybard driver on hibernate";
    before = [ "sleep.target" ];
    wantedBy = [ "sleep.target" ];
    unitConfig.StopWhenUnneeded = true;
    serviceConfig =
      let
        brightnessctl-kbd = ''${lib.getExe pkgs.brightnessctl} -d "*kbd*"'';
        modprobe = "${lib.getExe' pkgs.kmod "modprobe"}";
      in
      {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStartPre = "${brightnessctl-kbd} -s";
        ExecStart = "${modprobe} -r hid_asus";
        ExecStop = "${modprobe} hid_asus";
        ExecStopPost = "${brightnessctl-kbd} -r";
      };
  };
}
