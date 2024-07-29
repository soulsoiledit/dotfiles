{ lib, config, ... }:

{
  options = {
    opts.podman.enable = lib.mkEnableOption "enable podman";
  };

  config = lib.mkIf config.opts.podman.enable {

    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        autoPrune.enable = true;
      };
    };

    users.users.user.extraGroups = [ "podman" ];
  };
}
