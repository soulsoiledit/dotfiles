{
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    auto-optimise-store = true;
    use-xdg-base-directories = true;
    warn-dirty = false;

    experimental-features = [
      "flakes"
      "nix-command"
    ];
  };
}
