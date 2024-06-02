{ pkgs, ... }:

{
  users.users.user = {
    name = "soil";

    isNormalUser = true;
    shell = pkgs.fish;

    extraGroups = [
      "wheel"
      "video"
      "docker"
    ];
  };

  programs.fish.enable = true;
}
