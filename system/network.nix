{
  networking = {
    networkmanager = {
      enable = true;
      wifi = {
        powersave = true;
        backend = "iwd";
      };
    };
  };

  services = {
    openssh.enable = true;
  };
}
