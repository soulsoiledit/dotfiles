{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pwvucontrol

    steam
    prismlauncher
    olympus

    steam-run
    appimage-run

    distrobox
    lilipod
  ];
}
