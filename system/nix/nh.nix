{ config, ... }:

{
  programs.nh = {
    enable = true;
    flake = "${config.users.users.user.home}/code/dotfiles";

    clean = {
      enable = true;
      extraArgs = "--keep-since 14d";
    };
  };
}
