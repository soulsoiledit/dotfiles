{
  config,
  inputs,
  pkgs,
  ...
}:

{
  # make easier to allow unfree
  nixpkgs.config.allowUnfree = true;
  home.sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;

  imports = [ inputs.nix-index-database.hmModules.nix-index ];

  home.packages = with pkgs; [
    nix-tree
    nix-output-monitor
  ];

  programs = {
    nh = {
      enable = true;
      flake = "${config.xdg.configHome}/flake";
    };

    nix-index-database.comma.enable = true;
  };

  nix = {
    package = pkgs.nix;
    settings.use-xdg-base-directories = true;
  };

  xdg.configFile."nix/nix.conf".enable = false;
}
