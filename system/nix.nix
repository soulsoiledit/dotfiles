{
  nix = {
    settings = {
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
      options = "--delete-older-than 7d";
    };

    optimise.automatic = true;
  };
}
