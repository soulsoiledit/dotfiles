{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vesktop

    prismlauncher

    steam
    gamescope
    piper

    steam-run
    appimage-run
    distrobox

    drg-mint
  ];
}
