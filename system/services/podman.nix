{ lib, config, ... }:

{
  options.modules.podman.enable = lib.mkEnableOption "enable podman";

  config = lib.mkIf config.modules.podman.enable {
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        autoPrune.enable = true;
      };
    };

    users.users.user.extraGroups = [
      "podman"
      "docker"
    ];
  };
}
