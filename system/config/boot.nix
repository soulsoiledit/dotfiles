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

    # make boot quieter
    kernelParams = [ "quiet" ];
    initrd.verbose = false;
    # plymouth.enable = true;
  };
}
