{ pkgs, ... }:

{
  home.packages = with pkgs; [ brightnessctl scrot xclip acpi dunst ];

  xsession.windowManager.awesome.enable = true;
}
