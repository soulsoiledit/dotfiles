{ pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./nix.nix
    ./swap.nix
    ./users.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.stateVersion = "24.05";

  time.timeZone = "US/Central";

  programs = {
    git.enable = true;
    neovim.enable = true;

    appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
