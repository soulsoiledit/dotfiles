{ config, ... }:

{
  stylix.targets.firefox.enable = false;

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    profiles.${config.home.username} = { };
  };

  home.file.".mozilla/native-messaging-hosts".enable = false;
}
