{
  pkgs,
  config,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    inputs.eww.packages.${pkgs.system}.default
    acpi
    pavucontrol
    socat
    pulseaudio
  ];

  # used for making quick changes
  xdg.configFile."eww".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/dotfiles/home/eww";

  # battery notifications service
  services.batsignal.enable = true;
}
