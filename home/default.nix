{
  config,
  lib,
  ...
}:

{
  options.flake = lib.mkOption {
    type = lib.types.path;
    apply = toString;
    default = "${config.home.homeDirectory}/code/dotfiles";
    description = "Location of the flake";
  };

  config = {
    programs.home-manager.enable = true;

    home = {
      username = "soil";
      homeDirectory = "/home/soil";
      stateVersion = "24.05";
    };
    # TODO: gpg keysigning and ssh
  };
}
