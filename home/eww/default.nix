{
  pkgs,
  config,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    inputs.eww-tray.packages.x86_64-linux.eww
    acpi
    pavucontrol
    socat
    inotify-tools
    pulseaudio
  ];

  # used for making quick changes
  xdg.configFile."eww".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/dotfiles/home/eww";

  # battery notifications service
  services.batsignal.enable = true;
}
