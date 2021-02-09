{ pkgs, ... }:

{
  home.packages = with pkgs; [ imv ];
  xdg.configFile."imv/config".source = ./imvConfig;
}
