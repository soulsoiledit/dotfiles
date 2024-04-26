{ pkgs, ... }:

{
  users.users.soil = {
    isNormalUser = true;
    shell = pkgs.fish;

    extraGroups = [
      "wheel"
      "video"
      "networkmanager"
      "libvirtd"
      "docker"
    ];
  };

  programs.fish.enable = true;
}
