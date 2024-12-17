{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # libreoffice-fresh
    # inkscape

    vesktop
    piper

    steam

    prismlauncher
    cubiomes-viewer

    steam-run
    appimage-run
    distrobox
    # bottles
  ];
}
