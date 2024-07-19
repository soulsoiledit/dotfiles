{ pkgs, inputs, ... }:

{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.spicetify-nix.homeManagerModules.default

    ./nix.nix

    ./shell.nix
    ./files.nix
    ./git.nix
    ./editor
    ./fonts.nix

    # TODO: update
    ./desktop.nix
    # TODO: update
    ./widgets
    # TODO: update
    ./wm
    # TODO: update
    ./launcher.nix
    # TODO: update
    ./notify.nix
    # TODO: update
    ./screenlock.nix
    # TODO: update
    ./terminal
    # TODO: update
    ./firefox.nix
    # TODO: update
    ./spotify.nix
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
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };
}
