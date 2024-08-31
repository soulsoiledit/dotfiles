{ pkgs, ... }:

{
  users.users.user = {
    name = "soil";

    isNormalUser = true;
    shell = pkgs.fish;

    extraGroups = [
      "wheel"
    ];
  };

  programs.fish.enable = true;
}
