{ pkgs, inputs, ... }:

{
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

  programs.home-manager.enable = true;

  home = {
    username = "soil";
    homeDirectory = "/home/soil";
    stateVersion = "24.05";
    preferXdgDirectories = true;
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
