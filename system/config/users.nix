{ pkgs, ... }:

{
  users.users.default = {
    name = "soil";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
  };

  programs.fish.enable = true;
}
