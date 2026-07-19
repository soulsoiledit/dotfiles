{
  nix.settings = {
    use-xdg-base-directories = true;
    warn-dirty = false;
    experimental-features = [
      "flakes"
      "nix-command"
    ];
  };

  programs.nh.clean = {
    enable = true;
    extraArgs = "--keep-since 1week --keep-one --optimise";
  };
}
