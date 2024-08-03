{ config, ... }:

{
  programs.nh = {
    enable = true;
    flake = "${config.users.users.user.home}/code/dotfiles";
  };
}
