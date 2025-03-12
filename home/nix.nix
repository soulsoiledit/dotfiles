{
  inputs,
  pkgs,
  ...
}:

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
    package = pkgs.nix;
    settings.use-xdg-base-directories = true;
  };

  xdg.configFile."nix/nix.conf".enable = false;

  nixpkgs.config.allowUnfree = true;
}
