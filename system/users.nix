{ pkgs, ... }:

{
  users.users.soil = {
    isNormalUser = true;
    shell = pkgs.fish;

    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      # docker
    ];
  };

  # needed for setting shell ig
  programs.fish.enable = true;
}
