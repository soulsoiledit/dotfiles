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
}
