{ pkgs, ... }:

{

  # add support for xdg directories, not used system-wide for compat
  nix = {
    package = pkgs.nixStable;
    settings.use-xdg-base-directories = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };
}
