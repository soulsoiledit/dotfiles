{ config, lib, ... }:

let
  cfg = config.virtualisation.podman;
in
{
  virtualisation.podman = {
    dockerCompat = true;
    autoPrune.enable = true;
  };

  users.users.default.extraGroups = lib.mkIf cfg.enable [
    "podman"
    "docker"
  ];
}
