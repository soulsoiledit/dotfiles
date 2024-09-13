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
        After = [ "graphical-session.target" ];
        Wants = [ "graphical-session.target" ];
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
