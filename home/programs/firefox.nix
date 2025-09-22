{ config, ... }:

{
  stylix.targets.firefox.enable = false;

  programs.firefox = {
    enable = true;
    profiles.${config.home.username} = { };
  };
}
