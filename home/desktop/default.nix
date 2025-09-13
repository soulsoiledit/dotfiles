{ config, ... }:

let
  inherit (config.home) homeDirectory;
in
{
  xdg.userDirs = {
    enable = true;
    desktop = "${homeDirectory}";
    documents = "${homeDirectory}";
    download = "${homeDirectory}";
    music = "${homeDirectory}/music";
    pictures = "${homeDirectory}/pictures";
    publicShare = "${homeDirectory}";
    templates = "${homeDirectory}";
    videos = "${homeDirectory}/videos";
  };

  xdg.desktopEntries = {
    lock = {
      name = "Lock";
      exec = "loginctl lock-session";
      icon = "system-lock-screen";
    };

    sleep = {
      name = "Sleep";
      exec = "systemctl sleep";
      icon = "system-suspend";
    };

    hibernate = {
      name = "Hibernate";
      exec = "systemctl hibernate";
      icon = "system-hibernate";
    };

    logout = {
      name = "Logout";
      exec = "niri msg action quit --skip-confirmation";
      icon = "system-log-out";
    };

    reboot = {
      name = "Reboot";
      exec = "systemctl reboot";
      icon = "system-reboot";
    };

    shutdown = {
      name = "Shutdown";
      exec = "systemctl poweroff";
      icon = "system-shutdown";
    };
  };
}
