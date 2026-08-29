{
  xdg.desktopEntries = {
    lock = {
      name = "Lock";
      exec = "loginctl lock-session";
      icon = "system-lock-screen";
    };

    logout = {
      name = "Logout";
      exec = "niri msg action quit";
      icon = "system-log-out";
    };

    sleep = {
      name = "Sleep";
      exec = "systemctl sleep";
      icon = "system-suspend";
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
