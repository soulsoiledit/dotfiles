{ lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    # disable channels
    # channel.enable = false;

    settings = {
      # optimize nix store automatically
      auto-optimise-store = true;

      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };

  # fix running random binaries
  programs.nix-ld.enable = true;
}
