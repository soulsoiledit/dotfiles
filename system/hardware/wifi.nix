{
  networking.networkmanager.enable = true;
  users.users.default.extraGroups = [ "networkmanager" ];
}
