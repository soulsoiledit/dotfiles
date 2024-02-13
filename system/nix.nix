{ inputs, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    # disable channels to prevent unwanted errors
    channel.enable = false;

    # makes nix commands use same nixpkgs as system
    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      auto-optimise-store = true;

      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };

  programs.nix-ld.enable = true;
}
