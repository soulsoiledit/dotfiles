{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

with config.lib.file;
let
  target = config.wayland.systemd.target;
  ewwCmd = "${lib.getExe' pkgs.eww "eww"} --no-daemonize";
  ewwService = "eww-daemon.service";
in
{
  home.packages = with pkgs; [
    eww
    acpi
    pavucontrol
  ];

  # used for making quick changes
  xdg.configFile."eww".source = mkOutOfStoreSymlink (inputs.self.lib.relative config.flake ./.);

  systemd.user.services.eww-daemon = {
    Install.WantedBy = [ target ];

    Unit = {
      Description = "eww daemon";
      After = [ target ];
      PartOf = [ target ];
      BindsTo = [ "tray.target" ];
    };

    Service = {
      ExecStart = "${ewwCmd} daemon";
      Restart = "on-failure";
      RestartSec = "10";
    };
  };

  systemd.user.services.eww-bar = {
    Install.WantedBy = [ ewwService ];

    Unit = {
      Description = "eww bar";
      After = [ ewwService ];
      PartOf = [ ewwService ];
    };

    Service = {
      ExecStart = "${ewwCmd} open bar";
      Restart = "on-failure";
      RestartSec = "10";
    };
  };
}
