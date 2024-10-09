{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    eww
    acpi
    pavucontrol
    socat
  ];

  # used for making quick changes
  xdg.configFile = {
    "eww".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/dotfiles/home/programs/widget/eww";
  };
}
