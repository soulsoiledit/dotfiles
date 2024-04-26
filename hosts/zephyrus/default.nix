{ pkgs, ... }:

{
  imports = [ ./hardware.nix ];
  networking.hostName = "zephyrus";

  services = {
    upower.enable = true;

    asusd = {
      enable = true;
      enableUserService = true;
    };
  };

  programs.rog-control-center.enable = true;

  # colemakdh/kanata configuration ...
}
