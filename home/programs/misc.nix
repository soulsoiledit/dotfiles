{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vesktop
    piper

    steam
    prismlauncher
    cubiomes-viewer

    # bottles
    distrobox
    clipse

    steam-run
    appimage-run
  ];
}
