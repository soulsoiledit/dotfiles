{
  config,
  lib,
  pkgs,
  ...
}:

let
  target = config.wayland.systemd.target;
  ewwCmd = "${lib.getExe pkgs.eww} --no-daemonize";
  ewwService = "eww-daemon.service";
in
{
  programs.eww.enable = true;

  home.packages = with pkgs; [
    acpi
    pwvucontrol
  ];

  xdg.configFile."eww".source =
    config.lib.file.mkOutOfStoreSymlink config.flake + "/home/programs/eww";

  systemd.user.services = {
    eww-daemon = {
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

    eww-bar = {
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
  };
}
