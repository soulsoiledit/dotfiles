{ config, ... }:

let
  inherit (config.home) homeDirectory;
  inherit (config.xdg) dataHome;
in
{
  xdg.userDirs = {
    enable = true;
    setSessionVariables = false;
    desktop = "${dataHome}/applications/";
    documents = "${homeDirectory}/pictures";
    download = "${homeDirectory}";
    music = "${homeDirectory}/music";
    pictures = "${homeDirectory}/pictures";
    publicShare = "${homeDirectory}/public";
    templates = "${homeDirectory}/pictures";
    videos = "${homeDirectory}/videos";
  };
}
