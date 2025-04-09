{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vesktop

    prismlauncher

    steam
    piper
    drg-mint

    steam-run
    appimage-run

    distrobox
    lilipod

    wireshark
  ];
}
