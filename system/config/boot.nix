{
  boot = {
    kernelParams = [ "quiet" ];
    initrd.verbose = false;

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

    plymouth.enable = true;
  };
}
