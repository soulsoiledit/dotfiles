{ pkgs, ... }:

{
  home.packages = with pkgs; [ brightnessctl scrot xclip acpi dunst ];

  xdg.configFile."river/init" = {
    source = ./init;
    executable = true;
  };

  xsession.windowManager.command = "/home/soil/.config/river/init";
}
