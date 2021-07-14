{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brightnessctl scrot xclip
    acpi dunst

    (pkgs.writeShellScriptBin "bar" (lib.readFile ./bar.sh))
  ];

  # xsession.windowManager.awesome.enable = true;
  xsession.windowManager.command = "spectrwm";

  xdg.configFile."spectrwm/spectrwm.conf".source = ./spectrwm.conf;
}
