{ config, ... }:

let
  settingsFile = config.xdg.configFile."vicinae/settings.json";
in
{
  programs.vicinae = {
    enable = true;
    systemd.enable = true;
  };

  xdg.configFile = {
    "vicinae/settings.json".enable = false;
    "vicinae/nix-settings.json".source = settingsFile.source;
  };
}
