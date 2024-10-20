{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;

      timeout = 0;

      systemd-boot = {
        enable = true;
        configurationLimit = 16;
        consoleMode = "max";
        editor = false;
      };
    };

    # enable systemd in initramfs
    initrd.systemd.enable = true;

    # make boot quieter
    kernelParams = [ "quiet" ];
    initrd.verbose = false;
    # plymouth.enable = true;
  };
}
