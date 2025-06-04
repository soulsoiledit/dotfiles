{ config, ... }:

{
  programs.home-manager.enable = true;

  home = {
    username = "soil";
    homeDirectory = "/home/soil";
    stateVersion = "25.11";
  };

  flake = "${config.xdg.configHome}/flake";

  # TODO: gpg for ssh and git signing
}
