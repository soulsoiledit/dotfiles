{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pwvucontrol

    vesktop
    steam
    piper

    prismlauncher
    drg-mint

    steam-run
    appimage-run

    distrobox
    lilipod
    flatpak
  ];
}
