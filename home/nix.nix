{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [ inputs.nix-index-database.hmModules.nix-index ];

  options.flake = lib.mkOption {
    type = lib.types.str;
    description = "nix flake location";
  };

  config = {
    # make easier to allow unfree
    nixpkgs.config.allowUnfree = true;
    home.sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;

    home.packages = [ pkgs.nix-tree ];

    programs = {
      nh = {
        enable = true;
        flake = config.flake;
      };

      nix-index-database.comma.enable = true;
    };

    nix = {
      package = pkgs.nix;
      settings.use-xdg-base-directories = true;
    };

    xdg.configFile."nix/nix.conf".enable = false;
  };
}
