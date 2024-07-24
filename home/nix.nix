{ pkgs, inputs, ... }:

{
  imports = [ inputs.nix-index-database.hmModules.nix-index ];

  home.packages = with pkgs; [
    nix-tree
    nix-output-monitor
  ];

  programs = {
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
  };

  nix = {
    package = pkgs.nixStable;
    settings.use-xdg-base-directories = true;
  };

  nixpkgs.config.allowUnfree = true;
}
