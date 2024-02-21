{ inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    # disable channels to prevent state
    channel.enable = false;

    # makes nix commands use same nixpkgs as system
    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      # optimize nix store automatically
      auto-optimise-store = true;

      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };

  # enable running random binaries (sometimes)
  programs.nix-ld.enable = true;
}
