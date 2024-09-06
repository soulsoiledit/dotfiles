{ pkgs, lib, ... }:

let
  enable = false;
in
{
  config = lib.mkIf enable {
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      enable = true;

      Unit = {
        Description = "polkit-gnome-authentication-agent-1";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        Requisite = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
      };
    };
  };
}
