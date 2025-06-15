{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    pwvucontrol

    steam
    piper

    prismlauncher
    inputs.drg-mint.packages.${pkgs.system}.default

    steam-run
    appimage-run

    distrobox
    lilipod
    flatpak
  ];
}
