{ pkgs, config, ... }:

{
  home.packages = with pkgs; [ ags ];

  # used for making quick changes
  # xdg.configFile."eww".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/dotfiles/home/eww";

  # battery notifications service
  # services.batsignal.enable = true;
  services.poweralertd.enable = true;
}
