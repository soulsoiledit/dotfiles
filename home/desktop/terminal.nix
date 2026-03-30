{
  xdg = {
    mimeApps.defaultApplications."x-scheme-handler/terminal" = "xdg-terminal-exec";
    terminal-exec = {
      enable = true;
      settings.default = [
        "footclient.desktop"
        "foot.desktop"
        "Alacritty.desktop"
      ];
    };
  };
}
