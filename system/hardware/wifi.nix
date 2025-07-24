{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  users.users.default.extraGroups = [ "networkmanager" ];
}
