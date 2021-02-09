{ pkgs, ... }:

{
  home.packages = with pkgs; [
    spectrwm
    brightnessctl
    scrot
    xclip
  ];

  xsession.windowManager.command = "spectrwm";

  xdg.configFile."spectrwm/spectrwm.conf".source = ./spectrwm.conf;
}
