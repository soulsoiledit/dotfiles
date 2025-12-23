{ config, ... }:

let
  inherit (config.home) homeDirectory;
in
{

  xdg = {
    terminal-exec = {
      enable = true;
      settings.default = [
        "footclient.desktop"
        "foot.desktop"
        "Alacritty.desktop"
      ];
    };
    mimeApps.defaultApplications."x-scheme-handler/terminal" = "xdg-terminal-exec";

    userDirs = {
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
  };
}
