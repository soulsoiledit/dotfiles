{
  config,
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.nix-index-database.homeModules.nix-index ];

  # make easier to allow unfree
  nixpkgs.config.allowUnfree = true;
  home.sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;

  home.packages = [ pkgs.nix-tree ];

  programs = {
    nh = {
      enable = true;
      inherit (config) flake;
    };

    nix-index-database.comma.enable = true;
  };

  nix = {
    package = pkgs.nix;
    assumeXdg = true;
  };
}
