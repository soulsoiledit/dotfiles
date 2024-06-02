{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      autoPrune.enable = true;
    };
  };

  users.users.user.extraGroups = [ "podman" ];
}
