{
  nix = {
    settings = {
      auto-optimise-store = true;
      use-xdg-base-directories = true;
      warn-dirty = false;

      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      persistent = true;
      options = "--delete-older-than 14d";
    };
  };

  # nixpkgs.config.allowUnfree = true;
}
