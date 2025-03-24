{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vesktop

    prismlauncher

    steam
    gamescope
    piper
    drg-mint

    steam-run
    appimage-run

    distrobox
    lilipod

    wireshark
  ];
}
