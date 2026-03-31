{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;

      timeout = 0;

      systemd-boot = {
        enable = true;
        configurationLimit = 16;
        editor = false;
      };
    };

    initrd.systemd.enable = true;
  };
}
