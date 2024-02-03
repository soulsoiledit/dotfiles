{ pkgs, ... }:

{
  users.users.soil = {
    isNormalUser = true;
    shell = pkgs.fish;

    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
    ];
  };

  programs.fish.enable = true;
}
