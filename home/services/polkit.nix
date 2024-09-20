{ pkgs, lib, ... }:

let
  enable = false;
in
{
  config = lib.mkIf enable {
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = "gnome gtk polkit agent";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
