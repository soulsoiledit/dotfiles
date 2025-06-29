{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pwvucontrol

    steam
    piper

    prismlauncher
    olympus

    steam-run
    appimage-run

    distrobox
    lilipod
  ];
}
