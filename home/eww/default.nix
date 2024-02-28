{
  pkgs,
  config,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    # TODO: remove override when it is fixed
    (inputs.eww-tray.packages.x86_64-linux.eww-wayland.override { withWayland = true; })
    acpi
    pavucontrol
    socat
    inotify-tools
    pulseaudio
  ];

  # used for making quick changes
  xdg.configFile."eww".source = config.lib.file.mkOutOfStoreSymlink "/home/soil/code/dotfiles/home/eww";

  # battery notifications service
  services.batsignal.enable = true;
}
