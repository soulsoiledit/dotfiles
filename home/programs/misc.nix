{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # libreoffice-fresh
    # inkscape

    vesktop
    steam
    prismlauncher
    cubiomes-viewer
    piper

    steam-run
    appimage-run
    distrobox
    # bottles
  ];
}
