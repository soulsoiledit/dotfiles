{ pkgs, ... }:

{
  programs.fish.enable = true;
  users.users.default.shell = pkgs.fish;

  environment.localBinInPath = true;
}
