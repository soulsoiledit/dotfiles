{ config, ... }:

{
  programs.lf.enable = true;

  imports = [
    ./settings.nix
    ./keybindings.nix
    ./commands.nix
    ./icons.nix
  ];
}
