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

  # needed for setting shell
  programs.fish.enable = true;
}
