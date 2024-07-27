{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin

    ./nix.nix

    ./editor
    ./files.nix
    ./fonts.nix
    ./git.nix
    ./shell.nix

    ./desktop
    ./firefox.nix
    ./spotify.nix
    ./terminal
    ./widgets
    ./wm
  ];

  programs.home-manager.enable = true;

  home = {
    username = "soil";
    homeDirectory = "/home/soil";
    stateVersion = "23.11";
  };

  systemd.user.startServices = true;

  xdg.enable = true;

  home.packages = with pkgs; [
    vesktop
    piper

    prismlauncher
    cubiomes-viewer

    # bottles
    distrobox
    clipse
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };
}
